import copy
import numpy as np
from tqdm import tqdm
from time import sleep
from matplotlib import pyplot as plt

def CV_now(tm, CVS, CVD):
    tc = np.fmod(tm, T)
    if tc < TS:
        e = (1.0 - np.exp(-tc / tauS)) / (1.0 - np.exp(-TS / tauS))
        CV = CVD * np.power((CVS / CVD), e)
    else:
        e = (1 - np.exp(-(tc - TS) / tauD)) / (1 - np.exp(-(T - TS) / tauD))
        CV = CVS * np.power((CVD / CVS), e)
    return CV

def elastance(tmm,T,tau1,tau2,m1,m2,Emin,Emax,maxnum):
    tt = np.mod(tmm,T)
    g1 = np.power((tt/tau1), m1)
    g2 = np.power((tt/tau2), m2)
    g2T = np.power((T/tau2), m2)
    num1 = g1/(1+g1)
    num2 = (1/(1+g2)) - (1/(1+g2T))
    E = Emin + (Emax-Emin)*num1*num2/maxnum
    return E
    

def set_valves(Pold, Cold, Ci, Si, Gi):
    # script to find self - consistent valve states and pressures:
    done = 0  # not done yet!
    S_l = copy.deepcopy(Si)
    while ~done:  # if not done, keep trying
        S_noted = copy.deepcopy(S_l)  # note valve states
        # set pressures based on valve states:
        P_l = P_new(Pold, Cold, Ci, S_l, Gi)
        # then set valve states based on pressures:
        P_matrix = P_l * np.ones((1, N))
        S_l = (P_matrix > np.transpose(P_matrix))
        # done if all valve states are unchanged:
        done = np.all(np.all(S_l == S_noted))
    return P_l, S_l


def P_new(Pold, Cold, Ci, Si, Gi):
    A = -dt * (np.multiply(Si, Gi) + np.transpose(np.multiply(Si, Gi)))
    dd = np.diag(Ci.flatten()-(np.sum(A, axis=0))) + A
    A = dd
    tmp = np.linalg.solve(A, np.multiply(Cold, Pold))
    P_l = tmp
    CH = np.zeros((N, 1))
    if CHECK:
        for i_l in np.arange(N):
            CH[i_l] = -(Ci[i_l] * P_l[i_l, 0] - Cold[i_l] * Pold[i_l, 0]) / dt
            for j_l in np.arange(N):
                CH[i_l] = CH[i_l] + Si[j_l, i_l] * Gi[j_l, i_l] * (P_l[j_l, 0] - P_l[i_l, 0])
                CH[i_l] = CH[i_l] - Si[i_l, j_l] * Gi[i_l, j_l] * (P_l[i_l, 0] - P_l[j_l, 0])
        #print(CH) # Write out the  values of CH, which should be zero to within roundoff. \
    #print(P_l)
    return P_l


def meanvalue(A, klokmax1, T1, dt1, nc):
    ns = (T/dt)*nc
    # nc = number of cyles = 10
    # A = one diemsional array
    a = np.sum(A[(klokmax1-int(ns)+1):klokmax1])/ns
    return a



def circ_out():
    fig, a = plt.subplots(3)
    t_plot = t_plot.flatten()
    a[0].plot(t_plot, C_plot[iLV, :])
    a[1].plot(t_plot, P_plot[ipv, :])
    a[1].plot(t_plot, P_plot[iLV, :])
    a[1].plot(t_plot, P_plot[isa, :])
    a[2].plot(t_plot, Q_plot[jMi, :])
    a[2].plot(t_plot, Q_plot[jAo, :])

    fig, b = plt.subplots(3)
    b[0].plot(t_plot, C_plot[iRV, :])
    b[1].plot(t_plot, P_plot[isv, :])
    b[1].plot(t_plot, P_plot[iRV, :])
    b[1].plot(t_plot, P_plot[ipa, :])
    b[2].plot(t_plot, Q_plot[jTr, :])
    b[2].plot(t_plot, Q_plot[jPu, :])

    fig, c = plt.subplots()
    c.plot(t_plot, Q_plot[js, :])
    c.plot(t_plot, Q_plot[jp, :])

    fig, d = plt.subplots(2)
    d[0].plot(V_plot[iLV, :], P_plot[iLV, :])
    d[1].plot(V_plot[iRV, :], P_plot[iRV, :])
    plt.show()


def asd_out():
    if len(asd_vec) > 0:
        fig, a = plt.subplots(3)
        #t_plot = t_plot.flatten()
        a[0].plot(asd_vec*100, ppa_asd_vecA, marker="o")
        a[0].plot(asd_vec*100, psa_asd_vecA, marker="o")
        a[1].plot(asd_vec*100, ppa_asd_vecA, marker="o")
        a[2].plot(asd_vec*100, psa_asd_vecA, marker="o")
        a[0].grid()
        a[1].grid()
        a[2].grid()

        fig, b = plt.subplots()
        b.plot(asd_vec*100, q_asd_mean_vecA, marker="o")
        b.plot(asd_vec*100, q_asd_plus_vecA, marker="o")
        b.plot(asd_vec*100, q_asd_minus_vecA, marker="o")
        b.grid()

        fig, c = plt.subplots(3)
        c[0].plot(asd_vec*100, qs_asd_vecA, marker="o")
        c[1].plot(asd_vec*100, 10.* oxy_sa_asd_vecA, marker="o")
        c[2].plot(asd_vec*100, qs_asd_vecA * oxy_sa_asd_vecA, marker="o")
        c[0].grid()
        c[1].grid()
        c[2].grid()
        
        fig, d = plt.subplots()
        d.plot( t_plot.flatten()[(klokmax-(int(T / dt) * 10)+1):klokmax], Q_plot[jasd, (klokmax-(int(T / dt) * 10)+1):klokmax] )

        plt.show()



jasd = 6
jvsd = 7
jd = 8
j_shunt = jasd
asd_vec = np.arange(0, 1.1, 0.1)/100  # dm^2
ncase_asd = len(asd_vec)

# Each flow of interest
qAo_asd_vecA = np.zeros((1, ncase_asd)).flatten()
qs_asd_vecA = np.zeros((1, ncase_asd)).flatten()
qTr_asd_vecA = np.zeros((1, ncase_asd)).flatten()
qPu_asd_vecA = np.zeros((1, ncase_asd)).flatten()
qp_asd_vecA = np.zeros((1, ncase_asd)).flatten()
qMi_asd_vecA = np.zeros((1, ncase_asd)).flatten()

# Shunt flow mean
q_asd_mean_vecA = np.zeros((1, ncase_asd)).flatten()
q_asd_plus_vecA = np.zeros((1, ncase_asd)).flatten()
q_asd_minus_vecA = np.zeros((1, ncase_asd)).flatten()

# pressure in pulmonary artery and systemic artery
ppa_asd_vecA = np.zeros((1, ncase_asd)).flatten()
psa_asd_vecA = np.zeros((1, ncase_asd)).flatten()

# oxygen saturation in pulmonary artery and systemic artery
oxy_sa_asd_vecA = np.zeros((1, ncase_asd)).flatten()
oxy_pa_asd_vecA = np.zeros((1, ncase_asd)).flatten()

# mean value for above variables
for iA in tqdm(np.arange(len(asd_vec))):
    sleep(0.001)    
    Ashunt = asd_vec[iA]
    T = 0.0125  # Duration of heartbeat (minutes)
    tau1 = 0.269 * T # time scale of contraction (minutes)
    tau2 = 0.452 * T # duration of systole (minutes)
    m1 = 1.32
    m2 = 27.4
    # initialization of maxnum
    tt = np.arange(0, T+0.0001, T/1000)
    g1 = np.power((tt/tau1), m1)
    g2 = np.power((tt/tau2), m2)
    g2T = (T/tau2)**m2
    num1 = g1 / (1+g1)
    num2 = (1 / (1+g2)) - (1 / (1+g2T))
    maxnum = np.maximum((num1*num2).flatten(),0)
    EminLV = 0.08*1000 # (mmHg/L)
    EmaxLV = 3.00*1000 # (mmHg/L)
    EminRV = 0.04*1000 # (mmHg/L)
    EmaxRV = 0.60*1000 # (mmHg/L)

    tmax = 10 * T
    clockmax = 3000
    dt = int(tmax / clockmax)
    for clock in clockmax:
        t = clock * dt
        ELV[clock] = elastance(t,T,tau1,tau2,m1,m2,EminLV,EmaxLV,maxnum)
        ERV[clock] = elastance(t,T,tau1,tau2,m1,m2,EminLV,EmaxLV,maxnum)
        tsave[clock] = t
    plt.plot(tsave, ELV, tsave, ERV)
    plt.show()
    

    #TS = 0.0050  # Duration of systole   (minutes)
    #tauS = 0.0025  # CLV time constant during systole (minutes)
    #tauD = 0.0075  # CLV time constant during diastole (minutes)

    Rs = 17.5  # Systemic resistance  (mmHg/(liter/minute))
    Rp = 1.5 * Rs  # 1.79 # Pulmonary resistance (mmHg/(liter/minute))
  
    # Unrealistic valve resistances,
    # Chosen small enough to be negligible.
    RMi = 0.01  # mitral valve resistance (mmHg/(liter/minute))
    RAo = 0.01  # aortic valve resistance (mmHg/(liter/minute))
    RTr = 0.01  # tricuspid valve resistance (mmHg/(liter/minute))
    RPu = 0.01  # pulmonic valve  resistance (mmHg/(liter/minute))
    Rvisc = 0.01
    # The following values of Csa and Cpa are approximate.
    # They will need adjustment to make the systemic
    # blood pressure be roughly 120/80 mmHg
    # and to make the pulmonary
    # blood pressure be roughly 25/8 mmHg.
    Csa = 0.00175  # Systemic  arterial compliance (liters/mmHg)
    #Cpa = 0.00412  # Pulmonary arterial compliance (liters/mmHg)
    Cpa = Csa
    Csv = 1.75  # Systemic  venous compliance (liters/mmHg)
    Cpv = 0.08  # Pulmonary venous compliance (liters/mmHg)
    CLVS = 0.00003  # Min (systolic)  value of CLV (liters/mmHg)
    CLVD = 0.0146  # Max (diastolic) value of CLV (liters/mmHg)
    CRVS = CLVS  # 0.0002  # Min (systolic)  value of CRV (liters/mmHg)
    CRVD = CLVD  # 0.0365  # Max (diastolic) value of CRV (liters/mmHg)
    Vsad = 0.825  # Systemic arterial volume at P = 0 (liters)
    Vpad = 0.0382  # Pulmonary arterial volume at P = 0 (liters)
    Vsvd = 0  # Systemic venous volume at P = 0 (liters)
    Vpvd = 0  # Pulmonary venous volume at P = 0 (liters)
    VLVd = 0.010  # Left ventricular volume at P = 0 (liters)   -- 0.027
    VRVd = 0.055  # Right ventricular volume at P = 0 (liters)  -- 0.027
    dt = 0.01 * T  # Time step duration (minutes)
    # This choice implies 100 timesteps per cardiac cycle.
    klokmax = 15 * int(T / dt)  # Total number of timesteps
    # This choice implies simulation of 15 cardiac cycles.
    ifpmax= 10
    #the trouble comes from the fact that we set the conductance of the shunt based on 
    #its flow in the previous time step.  It would be better to use the flow in 
    #the present time step, but this is unknown.  To find it, we could try fixed-point iteration, 
    #which simply means that we repeat each time step some number of times, 
    #always adjusting the conductance accordingto the flow that we found on 
    #the latest pass through the time step.
    
    # Assign an index to each compliance vessel
    # of the model circulation:
    iLV = 0
    isa = 1
    isv = 2
    iRV = 3
    ipa = 4
    ipv = 5
    N = 6
    # Enter parameters and initial values
    # into correct slots in arrays.
    # Note that the code that follows is independent
    # of the specific numbering scheme chosen above.
    # Compliance vector:
    C = np.zeros((N, 1))
    # This makes C a column vector of length N.
    #C[iLV] = CV_now(0.0, CLVS, CLVD)  # initial value
    C[iLV] = 1/elastance(0,T,tau1,tau2,m1,m2,EminRV,EmaxRV,maxnum)
    C[isa] = Csa
    C[isv] = Csv
    #C[iRV] = CV_now(0.0, CRVS, CRVD)  # initial value
    C[iRV] = 1/elastance(0,T,tau1,tau2,m1,m2,EminRV,EmaxRV,maxnum)
    C[ipa] = Cpa
    C[ipv] = Cpv
    # print(C)  # This writes the result on the screen.
    # Pressure vector (initial values) at end of diastole:
    P = np.zeros((N, 1))
    # This makes P a column vector of length N.
    P[iLV] = 5
    P[isa] = 80
    P[isv] = 4  
    P[iRV] = 2
    P[ipa] = 100  
    P[ipv] = 5
    # print(P)  # This writes the result on the screen.
    # Vector of dead volumes (volume at zero pressure)
    # Note: Vd is only needed for output purposes.
    # It drops out of the equations we solve for P,
    # but we need it if we want to output (e.g.,  plot)
    # the volume of any compliance vessel.
    Vd = np.zeros((N, 1))
    # This makes Vd a column vector of length N.
    Vd[iLV] = VLVd
    Vd[isa] = Vsad
    Vd[isv] = Vsvd
    Vd[iRV] = VRVd
    Vd[ipa] = Vpad
    Vd[ipv] = Vpvd
    # print(Vd)
    # This writes the results on the screen.
    # Conductance matrix:
    G = np.zeros((N, N))
    # This makes G an NxN matrix filled with zeros.
    # Any element of G that is not explicitly
    # made nonzero remains zero,
    # thus modeling an infinite resistance connection,
    # that is,  no connection at all.
    G[iLV, isa] = 1 / RAo  # But G(isa, iLV) = 0 (no leak)
    G[isa, isv] = 1 / Rs  # no valve
    G[isv, isa] = 1 / Rs  # no valve
    G[isv, iRV] = 1 / RTr  # But G(iRV, isv) = 0  (no leak)
    G[iRV, ipa] = 1 / RPu  # But G(ipa, iRV) = 0  (no leak)
    G[ipa, ipv] = 1 / Rp  # no valve
    G[ipv, ipa] = 1 / Rp  # no valve
    G[ipv, iLV] = 1 / RMi  # But G(iLV, ipv) = 0  (no leak)
    # print(G)  # This writes the result on the screen.
    # Matrix of initial valve states:
    S = np.zeros((N, N))
    # This makes S an NxN matrix filled with zeros
    # (and writes it on the screen).
    # Start with all valves closed.
    # Valves will adjust to pressures
    # during first time step.
    # Initialize arrays to store data for plotting:
    t_plot = np.zeros((1, klokmax))
    C_plot = np.zeros((N, klokmax))
    P_plot = np.zeros((N, klokmax))
    V_plot = np.zeros((N, klokmax))
    Q_plot = np.zeros((N, klokmax))
    O2_plot = np.zeros((N, klokmax))
    # Other variables that we might want to plot
    # can be found from these.
    # For self-checking in P_new,  set CHECK = 1.
    # To skip self-checking set CHECK = 0.
    # (should be much faster with CHECK = 0)
    CHECK = 0
    # Initialize flow computation (for output purposes only)
    # assign an index to each flow of interest:
    jAo = 0
    js = 1
    jTr = 2
    jPu = 3
    jp = 4
    jMi = 5
    Nflows = 9
    # note index of upstream and downstream chamber
    # for each flow:
    iU = np.zeros((Nflows, 1))
    iD = np.zeros((Nflows, 1))
    iU[jAo] = iLV
    iD[jAo] = isa
    iU[js] = isa
    iD[js] = isv
    iU[jTr] = isv
    iD[jTr] = iRV
    iU[jPu] = iRV
    iD[jPu] = ipa
    iU[jp] = ipa
    iD[jp] = ipv
    iU[jMi] = ipv
    iD[jMi] = iLV

    # NEW three connections between the flow
    iU[jasd] = isv
    iD[jasd] = ipv
    iU[jvsd] = iRV
    iD[jvsd] = iLV
    iU[jd] = ipa
    iD[jd] = isa
    if Ashunt > 0:
        #print(int(iU[j_shunt, 0]))
        #print(int(iD[j_shunt, 0]))
        G[int(iU[j_shunt, 0]), int(iD[j_shunt, 0])] = 1 / Rvisc
        G[int(iD[j_shunt, 0]), int(iU[j_shunt, 0])] = 1 / Rvisc
    oxy_vec = np.ones((N, 1))*10  
    metabolism = np.zeros(np.shape(G))
    metabolism[isa, isv] = -16.8
    metabolism[ipa, ipv] = 0

    # extract the conductances from the matrix G:
    Gf = np.zeros((Nflows, 1))
    Gr = np.zeros((Nflows, 1))
    for j in np.arange(Nflows):
        Gf[j] = G[int(iU[j]), int(iD[j])]  # forward conductance
        Gr[j] = G[int(iD[j]), int(iU[j])]  # reverse conductance
    # create arrays to store current pressure differences
    # and history over time of the net flows:
    Pdiff = np.zeros((Nflows, 1))
    Q_plot = np.zeros((Nflows, klokmax))
    # create arrays to store current pressure differences

    #oxy_vec = np.zeros((N, 1)).flatten()
    
    
    for klok in np.arange(klokmax):
        t = (klok+1) * dt
        oxy_old_vec = copy.deepcopy(oxy_vec)
        P_old = copy.deepcopy(P)
        C_old = copy.deepcopy(C)
        Pdiff_old = P_old[iU.astype(int)].flatten() - P_old[iD.astype(int)].flatten()
        Q_old = np.multiply(np.multiply(Gf.flatten(), Pdiff_old > 0) + np.multiply(Gr.flatten(), Pdiff_old < 0), Pdiff_old)
        V_old = Vd[:, 0] + np.multiply(C_old, P_old)[:, 0]
        # find current values of left and right ventricular compliance and store each
        # of them in the appropriate slot in the array C:

        #C[iLV, 0] = CV_now(t, CLVS, CLVD)
        #C[iRV, 0] = CV_now(t, CRVS, CRVD)

        C[iLV, 0] = 1/elastance(t,T,tau1,tau2,m1,m2,EminLV,EmaxLV,maxnum)
        C[iRV, 0] = 1/elastance(t,T,tau1,tau2,m1,m2,EminLV,EmaxLV,maxnum)
        # find self - consistent valve states and pressures:

        # fixed-point interation
        for ifp in np.arange(ifpmax):
            P, S = set_valves(P_old, C_old, C, S, G)
            # store variables in arrays for future plotting
            t_plot[0, klok] = t
            C_plot[:, klok] = C[:, 0]
            P_plot[:, klok] = P[:, 0]
            V_plot[:, klok] = Vd[:, 0] + np.multiply(C, P)[:, 0]
            V = Vd[:, 0] + np.multiply(C, P)[:, 0]
            Pdiff = P[iU.astype(int)].flatten() - P[iD.astype(int)].flatten()  # pressure differences for flows of interest:
            Q_plot[:, klok] = np.multiply(np.multiply(Gf.flatten(), Pdiff > 0) + np.multiply(Gr.flatten(), Pdiff < 0), Pdiff)
            # (the net flow is computed in each case)
            rho = 1000./ (60*60*10*980*1.36)
            if Ashunt > 0:
                G[int(iU[j_shunt, 0]), int(iD[j_shunt, 0])] = 1 / (Rvisc + ((rho / (2 * Ashunt**2)) * np.abs(Q_plot[j_shunt, klok])))
                G[int(iD[j_shunt, 0]), int(iU[j_shunt, 0])] = 1 / (Rvisc + ((rho / (2 * Ashunt**2)) * np.abs(Q_plot[j_shunt, klok])))

                Gf[j_shunt]=G[int(iU[j_shunt, 0]), int(iD[j_shunt, 0])]
                Gr[j_shunt]=G[int(iD[j_shunt, 0]), int(iU[j_shunt, 0])] 
            Qp = S[ipa, ipv] * G[ipa, ipv] * (P[ipa] - P[ipv])
            metabolism[ipa, ipv] = Qp * (10 - oxy_old_vec[ipa])
            # Backward Euler Method
            oxy_vec = np.zeros((N, 1)).flatten()
            oxy_amt = np.zeros((N, 1))
            for i in np.arange(N):
                oxy_amt[i] = oxy_old_vec[i]*V_old[i]
                for j in np.arange(N):
                    if j != i:
                        Qij = S[i, j] * G[i, j] * (P[i] - P[j])
                        Qji = S[j, i] * G[j, i] * (P[j] - P[i])
                        oxy_amt[i] = oxy_amt[i] + dt * (oxy_old_vec[j] * Qji - oxy_old_vec[i] * Qij + metabolism[j, i])
                oxy_vec[i] = oxy_amt[i]/V[i]  
            #print(oxy_vec)    
            O2_plot[:, klok] = oxy_vec
        #circ_out()

    qAo_asd_vecA[iA] = meanvalue(Q_plot[jAo, :].flatten(), klokmax, T, dt, 10)
    qs_asd_vecA[iA] = meanvalue(Q_plot[js, :].flatten(), klokmax, T, dt, 10)
    qTr_asd_vecA[iA] = meanvalue(Q_plot[jTr, :].flatten(), klokmax, T, dt, 10)
    qPu_asd_vecA[iA] = meanvalue(Q_plot[jPu, :].flatten(), klokmax, T, dt, 10)
    qp_asd_vecA[iA] = meanvalue(Q_plot[jp, :].flatten(), klokmax, T, dt, 10)
    qMi_asd_vecA[iA] = meanvalue(Q_plot[jMi, :].flatten(), klokmax, T, dt, 10)

    q_asd_mean_vecA[iA] = meanvalue(Q_plot[jasd, :].flatten(), klokmax, T, dt, 10)
    q_asd_plus_vecA[iA] = meanvalue(np.maximum(Q_plot[jasd, :], 0).flatten(), klokmax, T, dt, 10)
    q_asd_minus_vecA[iA] = meanvalue(np.minimum(Q_plot[jasd, :], 0).flatten(), klokmax, T, dt, 10)

    ppa_asd_vecA[iA] = meanvalue(P_plot[ipa, :].flatten(), klokmax, T, dt, 10)
    psa_asd_vecA[iA] = meanvalue(P_plot[isa, :].flatten(), klokmax, T, dt, 10)
    oxy_sa_asd_vecA[iA] = meanvalue(O2_plot[isa, :].flatten(), klokmax, T, dt, 10)
    oxy_pa_asd_vecA[iA] = meanvalue(O2_plot[ipa, :].flatten(), klokmax, T, dt, 10)


asd_out()






