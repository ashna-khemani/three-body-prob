# Three-Body Problem
## Introduction
Modeling gravitational forces and movement of 3 bodies.
It's tougher than you might think! The 3BP can't really be definitely "solved" using a set number of equations/operations (no closed-form solution). 
The best one can really do is using power series (under certain initial conditions, mainly that angular velocity = 0, meaning we have no triple collisions). However, such a solution (Sundman's) is kind of useless; we don't get meaningful estimates until about 10<sup>8000000</sup> terms!

BUT! 
We can still have fun with the 3BP with some cool very-special case solutions. One of the first ones I came across was the "figure 8 solution," which was discovered and proved around 20-30 years ago. 

<img src="figure8-graph.jpg" alt="Graph: figure 8 periodic solution to 3BP" width="400"/>



Funky! There's tons of other cool solutions out there, resulting in polar flowers, cardioids, circles, and weirdly chaotic figure 8's. How do we know this? Because Henri Poincaré proved there's an infinte number 🙃

While I obviously can't find and model them *all*, I hope to model a few nifty ones!

## The Math
*Coming soon!*

Most of my "solution" models will use Verlet's solution. The gist of Verlet's is that we will estimate velocity using average acceleration. That is: $v_{t+1} = v_{t} + \dfrac{a_{t} + a_{t+1}}{2} \Delta t$

From introductory mechanics, we know the force of gravity is $|F_{g}| = \dfrac{GMm}{r^{2}}$ where:
- $G$ is the universal gravitational constant $6.67*10^{-11} [\dfrac{N*m^2}{kg^2}] $
- $M$ and $m$ are the masses of the two interacting bodies, measured in $kg$
- $r$ is the distance between the bodies, measured in $m$

But we're better than this! We'll use vectors. The force of gravity of $M$ on $m$ will be along the unit vector from $m$ to $M$. A quick Google search of unit vectors helps us see that this unit vector will be $\^{r} = \dfrac{\vec{r}}{|r|}$. So we can rewrite our initial gravity equation using vectors:
$$\vec{F_{g}} = \dfrac{GMm}{|r|^{2}} \^{r} = \dfrac{GMm}{|r|^{2}} \dfrac{\vec{r}}{|r|}$$
$$\Rightarrow \vec{F_{g}} = \dfrac{GMm}{|r|^{3}} \^{r}$$

Okay great. But what we *want* is the next position of a body (at time $t+1$). Again, from basic mechanics we know:
$$\vec{r_{t+1}} = \vec{r_{t}} + \vec{v_{t}} t + \dfrac{1}{2} \vec{a_{t}} t^{2}$$
where $t$ is the change in time between subsequent periods $t+1$ and $t$. And we can find the other values:
- $v_{t+1} = v_{t} + \dfrac{a_{t} + a_{t+1}}{2} t$ (Verlet's approximation from above!)
- $\vec{a_{t}} = \dfrac{\vec{F_{g}}}{m}$

Now we have all the equations we need, and the relationships between them. The steps we can use to find the position of a body after some time are the following:
1. Givens: mass $m$, initial position $\vec{r_{t}}$, velocity $\vec{v_{t}}$, and acceleration $\vec{a_{t}}$
2. Find distance between each body.
3. Find $F_g$ using the masses (known), $G$ (known), distances (step 2)
4. Find $a_t = \dfrac{F_g}{m}$
5. Find new position: $\vec{r_{t+1}} = \vec{r_{t}} + \vec{v_{t}} t + \dfrac{1}{2} \vec{a_{t}} t^{2}$
6. Find new acceleration (will be used to calculate new velocity): repeat steps 2-4 to get $a_{t+1}$
7. Find new velocity $v_{t+1} = v_{t} + \dfrac{a_{t} + a_{t+1}}{2} t$
8. Plot positions found in step 5
9. 😎

Note that $t$ in the above equations is a change in time between periods (your timestep). This is something I've defined in the code, set as 0.02sec.

And that's it!

## Guide to Examples
*Coming Soon*