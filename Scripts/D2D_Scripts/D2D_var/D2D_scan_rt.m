% This script defines the scan rate (code from L.J.F.H).

%% - - - - - - - - - - CODE START - - - - - - - - - -

% - - - - - - - - - - data inputs
input = 'Input_files/pmpi_v2.csv';
scan_rts = [0.1, 0.2, 0.3, 0.4, 0.5];

% - - - - - - - - - - handle
sols = cell(1, length(scan_rts)); % solutions cell array

% - - - - - - - - - - data processing
par = pc(input);
par.prob_distro_function = 'Boltz';
par.tmesh_type = 'linear';
xpos = 0;
soleq = equilibrate(par);

% - - - - - - - - - - do measurements
for i = 1:length(scan_rts)
    sol = doCV(soleq.ion, 0, 0, -1, 1, scan_rts(i), 1, 1000); % solution
    sols{i} = sol;
end

%% - - - - - - - - - - plot
dfplot_ionic.d2d_var(sols, xpos);
