% http://eidors3d.sourceforge.net/tutorial/EIDORS_basics/tutorial010.shtml

figure();
subplot(121);

% 2D model
imdl_2d = mk_common_model('b2c', 16);
show_fem(imdl_2d.fwd_model);

axis square;
subplot(122);

% 3D model
imdl_3d = mk_common_model('n3r2', [16, 2]); % 'd3cr'
show_fem(imdl_3d.fwd_model);

axis square;
view(-35, 14);
%print_convert('tutorial010a.png','-density 100');

figure();
sim_img = mk_image(imdl_3d.fwd_model, 1);

% set voltage and current stimulation patterns
stim = mk_stim_patterns(16, 2, [0, 1], [0, 1], {}, 1);
sim_img.fwd_model.stimulation = stim;

% set homogeneous conductivity and simulate
homg_data = fwd_solve(sim_img);

% set inhomogeneous conductivity and simulate
sim_img.elem_data([390, 391, 393, 396, 402, 478, 479, 480, 484, 486, ...
                   664, 665, 666, 667, 668, 670, 671, 672, 676, 677, ...
                   678, 755, 760, 761]) = 1.15;
sim_img.elem_data([318, 319, 321, 324, 330, 439, 440, 441, 445, 447, ...
                   592, 593, 594, 595, 596, 598, 599, 600, 604, 605, ...
                   606, 716, 721, 722]) = 0.8;
inh_data = fwd_solve(sim_img);

subplot(511);
xax = 1:length(homg_data.meas);
hh_homg = plot(xax, homg_data.meas);
subplot(512);
hh_inhomg = plot(xax, inh_data.meas);
subplot(513);
hh_super = plot(xax, [homg_data.meas, inh_data.meas]);
subplot(514);
hh_diff = plot(xax, homg_data.meas - inh_data.meas);
subplot(515);
hh = plotyy(xax, [homg_data.meas, inh_data.meas], ...
            xax, homg_data.meas - inh_data.meas);
%set(hh, 'xlim', [1, max(xax)]);
%print_convert('tutorial010b.png', '-density 75');

figure();
subplot(311);
h1 = plot(xax, inh_data.meas);

% add 20dB SNR noise to data
subplot(312);
noise_level = std(inh_data.meas - homg_data.meas) / 10^(20/20);
noise = noise_level * randn(size(inh_data.meas));
h2 = plot(xax, noise);

subplot(313);
inh_data.meas = inh_data.meas + noise;
h3 = plot(xax, inh_data.meas);

figure();
subplot(131);
show_fem(sim_img);

% reconstruct
rec_img = inv_solve(imdl_3d, homg_data, inh_data);

% show reconstruction as a 3D mesh
subplot(132);
show_fem(rec_img);

subplot(133);
rec_img.calc_colours.npoints = 128;
show_slices(rec_img, [inf, inf, 2.99, 1, 1; ...
                      inf, inf, 2.0, 1, 2; ...
                      inf, inf, 1.0, 1, 3; ...
                      inf, inf, 0.5, 1, 4]);
%print_convert('tutorial010c.png', '-density 100', 0.5);
