import atmosphere as atm
import numpy as np

def soyuz(t,y, Cd, mu, LD, Re, m, S):
    rho = atm.density((y[0]-Re))
    D = 0.5*rho*S*Cd*(y[3]**2)
    L = LD * D
    
    ydot1 = y[3] * np.sin(y[2])
    ydot2 = ((y[3]/y[0]) * np.cos (y [2]))
    ydot3 = (((y[3]/y[0]) * np.cos (y[2]))) - ((mu * np.cos(y[2])) / (y[0]**2 * y[3])) + ((LD/(2*m)) * (rho * S * Cd * (y[3])))
    ydot4 = ((-1/(2*m)) * (rho * S * Cd * (y[3]**2))) - ((mu/(y[0]**2)) * np.sin(y[2]))
    
    #ydot1 = y[3] * np.sin(y[2])
    #ydot2 = (y[3] * np.cos(y[2])) / y[0]
    #ydot3 = -(D/m) - ((fg/m)*np.sin(y[2]))
    #ydot4 = ((y[3] * np.cos(y[2]))/y[0]) + (L/(m*y[3])) - ((fg/(m*y[3]))*np.cos(y[2]))
    
    #ydot1 = y[3] * np.sin(y[2])
    #ydot2 = ((y[3]/y[0]) * np.cos(y[2]))
    #ydot3 = (((y[3]/y[0]) * np.cos(y[2]))) - ((mu * np.cos(y[2])) / (y[0]**2 * y[3])) + ((1/(2*m*y[3])) * LD * rho * S * Cd * (y[3]**2))
    #ydot4 = ((-1/(2*m)) * rho * S * Cd * (y[3]**2)) - ((mu/(y[0]**2)) * np.sin(y[2]));
    return [ydot1, ydot2, ydot3, ydot4]