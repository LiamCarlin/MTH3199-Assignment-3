%This function computes the value of X at the next time step
%using the explicit midpoint approximation
%INPUTS:
%rate_func_in: the function used to compute dXdt. rate_func_in will
% have the form: dXdt = rate_func_in(t,X) (t is before X)
%t: the value of time at the current step
%XA: the value of X(t)
%h: the time increment for a single step i.e. delta_t = t_{n+1} - t_{n}
%OUTPUTS:
%XB: the approximate value for X(t+h) (the next step)
% formula depends on the integration method used
%num_evals: A count of the number of times that you called
% rate_func_in when computing the next step
function [XB,num_evals] = explicit_midpoint_step(rate_func_in,t,XA,h)
    
    XBA = XA + (h./2).*wrapper(rate_func_in(t, XA)); % Midpoint
    XB = XA + h.*wrapper(rate_func_in(t + h./2, XBA)); %Jump

    num_evals = count('g'); %count output

end

function output = wrapper(func)
    count('c'); %The actual counting
    output = func; %wrappping
end

function n = count(action) %lk inspo from like a matlab forum but dw i get how it works
    persistent n_count %makes this like a variable that remembers its value between calls
    if isempty(n_count) %init
        n_count = 0;
    end

    switch action
        case 'c' %counting
            n_count = n_count +1;
        case 'r' %if called to reset
            n_count = 0;
        case 'g' %call if you want to get final total
    end
    n = n_count;
end