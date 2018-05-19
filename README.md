# 03-seismic-active-control

This repository consists of Matlab scripts that produced results for my third research paper

## Description

The goal of the research is to test our control algorithm in the simulation of the building excited by an earthquake. The finite element model of the building is simulated in Ansys. The algorithm is compared to the LQG regulator.
Apart from the algorithm logic itself, the interface between Matlab and Ansys is also established.

While I believe that the whole simulation program, as a part of scientific research, is intended to be run limited number of times, I decided to develop its logic according to the object-oriented paradigm.
The reasoning for such a decision is twofold - whole simulation setting is very easy to split into objects - it consists of the building, sensors, actuators, controllers and the distrubance (in our case an earthquake) and it makes it easier to try out different approaches, that is, different algorithms or actuators.

In the **identification** folder, scripts for establishing simplified model of the building are placed.

The **forFigures** contains scripts that I used for making plot of the results that are consistent and meet the journal's requirements.

The **data** folder contains the whole time course of the simulations.
