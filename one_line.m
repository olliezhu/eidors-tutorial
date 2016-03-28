% http://eidors3d.sourceforge.net/tutorial/EIDORS_basics/one_line.shtml

load montreal_data_1995;

figure();
show_slices(inv_solve(mk_common_model('d2c2', 16), zc_h_demo4, zc_demo4));

imdl = mk_common_model('d2c2', 16);
n_rings = 12;
n_electrodes = 16;
three_d_layers = []; % no 3D
fmdl = mk_circ_tank(n_rings, three_d_layers, n_electrodes);

options = {'no_meas_current', 'no_rotate_meas'};
[stim, meas_select] = mk_stim_patterns(16, 1, '{ad}', '{ad}', options, 1);
imdl.fwd_model.stimulation = stim;
imdl.fwd_model.meas_select = meas_select;

data_homg = zc_h_demo4;
data_objs = zc_demo4;
img = inv_solve(imdl, zc_h_demo4, zc_demo4);

figure();
show_slices(img);
