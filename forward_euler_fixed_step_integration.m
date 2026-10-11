%Runs numerical integration using forward Euler approximation
%INPUTS:
%rate_func_in: the function used to compute dXdt. rate_func_in will
% have the form: dXdt = rate_func_in(t,X) (t is before X)
%tspan: a two element vector [t_start,t_end] that denotes the integration endpoints
%X0: the vector describing the initial conditions, X(t_start)
%h_ref: the desired value of the average step size (not the actual value)
%OUTPUTS:
%t_list: the vector of times, [t_start;t_1;t_2;...;.t_end] that X is approximated at
%X_list: the vector of X, [X0';X1';X2';...;(X_end)'] at each time step
%h_avg: the average step size
%num_evals: total number of calls made to rate_func_in during the integration
function [t_list,X_list,h, num_evals] = forward_euler_fixed_step_integration(rate_func_in,tspan,X0,h_ref)
    N = ceil((tspan(2) - tspan(1))/h_ref); % href > h --> href > (tf-t0)/N --> N > (tf-t0)/href
    h = (tspan(2) - tspan(1))/N;
    X_list = zeros(N+1, 1);
    X_list(1) = X0;
    num_evals = 0;
    t_list = tspan(1):h:tspan(2); % t_list is indep. of the actual math and only depends on h so compute it now instead of in loop

    if t_list(end) ~= tspan(2)
        return; %Last input to t_list should be end of integration array
    end

    for i=1:N
        [xa, count] = forward_euler_step(rate_func_in,t_list(i),X_list(i),h);
        X_list(i+1) = xa;
        num_evals = num_evals + count;
    end
end