function a = meanvalue(A, klokmax, T, dt, nc)
    ns = (T/dt)*nc; 
    % nc = number of cyles = 10
    % A = one dimesional arry
    a = sum(A((klokmax-ns+1):klokmax))/ns;
end
