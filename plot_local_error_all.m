h = logspace(-5,1,100);
t = 0.492;

func = @(t,X) -5*X + 5*cos(t) - sin(t);
XA = cos(t);

errors = zeros(4,length(h));

for i = 1:length(h)
    exact = cos(t+h(i));

    [XF,~] = forward_euler_step(func,t,XA,h(i));
    [XB,~] = backward_euler_step(func,t,XA,h(i));
    [XE,~] = explicit_midpoint_step(func,t,XA,h(i));
    [XI,~] = implicit_midpoint_step(func,t,XA,h(i));

    errors(1,i) = abs(XF-exact);
    errors(2,i) = abs(XB-exact);
    errors(3,i) = abs(XE-exact);
    errors(4,i) = abs(XI-exact);
end

figure('Color','w');

loglog(h,errors(1,:),'r.', h,errors(2,:),'m.', h,errors(3,:),'b.', h,errors(4,:),'k.','MarkerSize',10);

xlabel('Step size h (-)','Interpreter','latex');
ylabel('Local truncation error (-)','Interpreter','latex');
title('Local Error Scaling: All Four Methods','Interpreter','latex');

legend('Forward Euler','Backward Euler', 'Explicit midpoint','Implicit midpoint', 'Interpreter','latex','Location','eastoutside','FontSize',12);

set(gca,'FontSize',16,'TickLabelInterpreter','latex');

exportgraphics(gcf,'local_error_all_methods.png','Resolution',600);