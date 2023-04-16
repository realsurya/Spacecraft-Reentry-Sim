import atmosphere as atm
import numpy as np

def soyuz(t,y, Cd, mu, LD, Re, m, S):
    rho = atm.density((y[1])/1000)
    D = 0.5*rho*S*Cd*(np.sqrt(y[2]**2 + y[3]**2))**2
    L = LD * D
    
    theta = np.arctan(y[3]/y[2])
    stheta = (y[2]/np.sqrt(y[2]**2 + y[3]**2))
    ctheta = (y[3]/np.sqrt(y[2]**2 + y[3]**2))
    
    g = 9.8

    ydot1 = y[2]
    ydot2 = y[3]
    ydot3 = ((L/m)*stheta) - ((D/m)*ctheta)
    ydot4 = ((L/m)*ctheta) - g + ((D/m)*stheta)
    
    return [ydot1, ydot2, ydot3, ydot4]