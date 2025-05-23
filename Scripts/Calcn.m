%Code to calculate charge stored on device active layers

num = 2;
nbar = cell(num,1);
pbar = cell(num,1);
npbar = cell(num,1);
Rsrh = cell(num,1);

for i = 1:num
    sol = solCV{i};
    w = sol.par.d_active;
    num_start = sum(sol.par.layer_points(1:2))+1;
    num_stop = num_start + sol.par.layer_points(3)-1;
    x = sol.x;
    nbar{i} = trapz(x(num_start:num_stop), sol.u(:,num_start:num_stop,2),2)/w;
    pbar{i} = trapz(x(num_start:num_stop), sol.u(:,num_start:num_stop,3),2)/w;
    npbar{i} = trapz(x(num_start:num_stop), (sol.u(:,num_start:num_stop,2).*sol.u(:,num_start:num_stop,3)).^0.5,2)/w;
    Rsrh{i} = trapz(x(num_start:num_stop), dfana.calcr(sol, "whole").srh(:,num_start:num_stop),2)/w;
end

%%
figure('Name', 'carirrier bar')

%which = 21+round(100*Stats_array(:,1,2));
which = ones(num).*21+100;
values = zeros(num,3);
r = zeros(num,1);
hold on 
for j = 1:num
    plot(j, nbar{j}(which(j)), 'Marker', 'o')
    plot(j, pbar{j}(which(j)), 'Marker', 'x')
    plot(j, npbar{j}(which(j)), 'Marker', 's')
    values(j,1) = nbar{j}(which(j));
    values(j,2) = pbar{j}(which(j));
    values(j,3) = npbar{j}(which(j));
    r(j) = Rsrh{j}(which(j));
end

hold off
 





