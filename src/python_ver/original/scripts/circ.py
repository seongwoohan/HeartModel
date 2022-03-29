from in_circ import *

for klok in np.arange(klokmax):
    t = (klok+1) * dt
    P_old = copy.deepcopy(P)
    C_old = copy.deepcopy(C)
    # find current values of left and right ventricular compliance and store each
    # of them in the appropriate slot in the array C:
    C[iLV, 0] = CV_now(t, CLVS, CLVD)
    C[iRV, 0] = CV_now(t, CRVS, CRVD)
    # find self - consistent valve states and pressures:
    P, S = set_valves(P_old, C_old, C, S, G)
    # store variables in arrays for future plotting
    t_plot[0, klok] = t
    C_plot[:, klok] = C[:, 0]
    P_plot[:, klok] = P[:, 0]
    V_plot[:, klok] = Vd[:, 0] + np.multiply(C, P)[:, 0]
    Pdiff = P[iU.astype(int)].flatten() - P[iD.astype(int)].flatten()  
    # pressure differences for flows of interest:
    Q_plot[:, klok] = np.multiply(np.multiply(Gf.flatten(), Pdiff > 0) + np.multiply(Gr.flatten(), Pdiff < 0), Pdiff)
    # (the net flow is computed in each case)
circ_out()
