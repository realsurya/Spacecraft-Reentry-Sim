import atmosphere as atm
import numpy as np

def soyuz(t,y, Cd, mu, LD, Re, m):
    rho = alt.density((y[0]-Re)*1000)
    ydot1 = y[3] * np.sin(y[2])
    ydot2 = ((y[3]/y[0]) * np.cos (y [2]))
    ydot3 = (((y[3]/y[0]) * np.cos (y[2]))) - ((mu * np.cos(y[2])) / (y[0]**2 * y[3])) + ((LD/(2*m)) * (rho * S * Cd * (y[3])))
    ydot4 = ((-1/(2*m)) * (rho * S * Cd * (y[3]**2))) - ((mu/(y [0]**2)) * np.sin(y[2]))
    return [ydot1, ydot2, ydot3, ydot4]