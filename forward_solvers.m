% http://eidors3d.sourceforge.net/tutorial/EIDORS_basics/forward_solvers.shtml

% 2D model (originally d2d1c)
imdl = mk_common_model('i2d2c', 19);

% create an homogeneous image
figure();

img_1 = mk_image(imdl);
h1a = subplot(121);
show_fem(img_1);

% add circular object at (0.2, 0.5)
% calculate element membership in object
img_2 = img_1;
select_fcn = inline('(x-0.2).^2+(y-0.5).^2<0.1^2', 'x', 'y', 'z');
mem_frac = elem_select(img_2.fwd_model, select_fcn);
img_2.elem_data = 1 + mem_frac;
h1b = subplot(122);
show_fem(img_2);
img_2.calc_colours.cb_shrink_move = [0.3, 0.8, -0.02];
common_colourbar([h1a, h1b], img_2);
%print_convert forward_solvers01a.png

% stimulation patterns
figure();

% calculate adj stimulation pattern
stim = mk_stim_patterns(19, 1, [0, 1], [0, 1], {}, 1);  % '{ad}'

% solve all voltage patterns
img_2.fwd_model.stimulation = stim;
img_2.fwd_solve.get_all_meas = 1;
vh = fwd_solve(img_2);

% show first stim pattern
h2a = subplot(221);
img_v = rmfield(img_2, 'elem_data');
img_v.node_data = vh.volt(:, 1);
show_fem(img_v);

% show 7th stim pattern
h2b = subplot(222);
img_v = rmfield(img_2, 'elem_data');
img_v.node_data = vh.volt(:, 7);
show_fem(img_v);

img_v.calc_colours.cb_shrink_move = [0.3, 0.8, -0.02];
common_colourbar([h2a, h2b], img_v);
%print_convert forward_solvers02a.png

% calculate [0, 9] stimulation pattern
stim = mk_stim_patterns(19, 1, [0, 9], [0, 1], {}, 1);

% solve all voltage patterns (overwrite stimulation)
img_2.fwd_model.stimulation = stim;
img_2.fwd_solve.get_all_meas = 1;
vh = fwd_solve(img_2);

% show first stim pattern
h2c = subplot(223);
img_v = rmfield(img_2, 'elem_data');
img_v.node_data = vh.volt(:, 1);
show_fem(img_v);

% show 7th stim pattern
h2d = subplot(224);
img_v = rmfield(img_2, 'elem_data');
img_v.node_data = vh.volt(:, 7);
show_fem(img_v);

img_v.calc_colours.cb_shrink_move = [0.3, 0.8, -0.02];
common_colourbar([h2c, h2d], img_v);
%print_convert forward_solvers03a.png

% homogeneous vs inhomogeneous stimulation pattern
figure();

stim = mk_stim_patterns(19, 1, [0, 1], [0, 1], {}, 1);

% solve voltage patterns
img_1.fwd_model.stimulation = stim;
img_1.fwd_solve.get_all_meas = 1;
vh1 = fwd_solve(img_1);
img_2.fwd_model.stimulation = stim;
img_2.fwd_solve.get_all_meas = 1;
vh2 = fwd_solve(img_2);

img_v = rmfield(img_2, 'elem_data');

% homogeneous image
h3a = subplot(131);
img_v.node_data = vh1.volt(:, 1);
show_fem(img_v); axis equal;

% inhomogeneous image
h3b = subplot(132);
img_v.node_data = vh2.volt(:, 2);
show_fem(img_v); axis equal;

% difference image
h3c = subplot(133);
img_v.node_data = vh1.volt(:, 1) - vh2.volt(:, 1);
show_fem(img_v); axis equal;

img_v.calc_colours.cb_shrink_move = [0.3,0.8,-0.05];
common_colourbar([h3a, h3b, h3c], img_v);
%print_convert forward_solvers04a.png

% current patterns
figure();

% solve voltage patterns
img_2.fwd_model.get_all_meas = 1;
img_2.fwd_model.mdl_slice_mapper.npx = 64;
img_2.fwd_model.mdl_slice_mapper.npy = 64;

% show [0-3] stim pattern
subplot(121);
stim = mk_stim_patterns(19, 1, [0, 3], [0, 1], {}, 1);
img_2.fwd_model.stimulation = stim;
vh = fwd_solve(img_2);
show_current(img_2, vh.volt(:, 1));
axis([-1, 1, -1, 1]); axis equal, axis tight;

% show [2-9] stim pattern
subplot(122);
stim = mk_stim_patterns(19, 1, [0, 7], [0, 1], {}, 1);
img_2.fwd_model.stimulation = stim;
vh = fwd_solve(img_2);
show_current(img_2, vh.volt(:, 3));
axis([-1, 1, -1, 1]); axis equal, axis tight;
%print_convert forward_solvers05a.png
