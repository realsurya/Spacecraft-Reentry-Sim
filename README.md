# Spacecraft-Reentry-Sim

## What is this?
This repository houses all code for the AAE 338 (Thermal Sciences) final project for Purdue University.

This project was inspired by the ECS system failure and coolant leak on the Soyuz MS-22 vehicle. Soyuz MS-22 was impacted by a micro-meteor causing a severe leak of onboard coolant on the ECS radiatior loops. Thus, the crew were forced to re-enter Earth on a separate rescue vehicle (Soyuz MS-23), leaving the damaged spacecraft to re-enter autonomously.

Our group was interested in simulating the re-entry of Soyuz MS-22 using knowledge from dynamics classes. Additionally, we leveraged knowledge from AAE 338 (and made a lot of assumptions) to calculate the heating and internal temperature of the spacecraft over time. Ultimately, we were interested in assessing the probability of crew survival if they were forced to re-enter on the damaged spacecraft.

Feel free to browse the code! The code is thoroughly commented so it should be readable to outsiders.

## Running Instructions
The project was initially written in Python, but I instead switched to MATLAB to make it easier for all group members to understand the code.

To run this project, simply use MATLAB to run the `Reentry_Runner.m` script. This main file will make all the calls necessary to plot the re-entry profile and thermal analysis.

## Final Report
For those interested in reading the final report, it can be found in the `Results` folder. I promise it's an interesting read!

## Abridged Results
The code in this repository produces the following plots:

### Re-entry Trajectory Simulation Results
![Soyuz Re-entry Trajectory Plots](Results/Trajectory_Results.png)
### Re-entry Thermal Simulation Results
![Soyuz Re-entry Heating Plots](Results/Heat_Results.png)
### Crew / Spacecraft Danger Analysis
![Internal Temperature Plot With Temp Limits](Results/Human_Factors_Temp.png)

