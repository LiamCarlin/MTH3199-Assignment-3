%Implementation of finite difference approximation
%for Jacobian of multidimensional function
%INPUTS:
%fun: the mathematical function we want to differentiate
%X: the input value of fun that we want to compute the derivative at
%OUTPUTS:
%J: approximation of Jacobian of fun at x
% num_evals: the number of times a rate function has been called
function [J, num_evals] = approximate_jacobian(fun,X)
    %set the step size to be tiny
    dx_scalar = 1e-6;
    
    f0 = wrapper(fun(X)); %evaluate function to determine number of outputs
    
    num_in = length(X);     %determine dimension of the input vector
    num_out = length(f0);   %determine dimension of the output vector
    
    %initialize the dx vector
    dX = zeros(size(X));

    %initialize the Jacobian to be a matrix
    %with height num_out and width num_in
    J = zeros([num_out,num_in]);

    %iterate through each scalar input of fun
    for n = 1:num_in
        %set dx vector so it has the form:
        %[0,...,0,dx_scalar,0,...,0]^T
        %where the nonzero element is at dx
        dX(n) = dx_scalar;

        %Use finite differences to compute the vector dfun/dx_n
        %partial derivative of the function 
        %w/respect to the nth element of X
        %the result should be a vector quantity

        dfdx = (wrapper(fun(X + dX)) - wrapper(fun(X - dX)))/(2*dx_scalar);

        %Set the nth column of J to dfun/dx_n

        J(:, n) = dfdx;


        dX(n) = 0; %reset the dx vector to [0,...,0]^T
    end
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