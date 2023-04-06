clear all
% load semucb
fn1 = 'conduit_major\SEMUCB\EAR_200.csv';
fn2 = 'conduit_major\SEMUCB\Easter_200.csv';
fn3 = 'conduit_major\SEMUCB\Iceland_200.csv';
fn4 = 'conduit_major\SEMUCB\Tristan_200.csv';
fn5 = 'conduit_major\SEMUCB\Louisville_200.csv';
fn6 = 'conduit_major\SEMUCB\Reunion_200.csv';
fn7 = 'conduit_major\SEMUCB\Hawaii_200.csv';
fn8 = 'conduit_major\SEMUCB\Samoa_200.csv';
fn9 = 'conduit_major\SEMUCB\Tahiti_200.csv';
fn10 = 'conduit_major\SEMUCB\Mac_200.csv';
fn11 = 'conduit_major\SEMUCB\Pitcairn_200.csv';
fn12 = 'conduit_major\SEMUCB\Gala_200.csv';
fn13 = 'conduit_major\SEMUCB\Marquesas_200.csv';
fn14 = 'conduit_major\SEMUCB\Kerguelen_200.csv';
fn15 = 'conduit_major\SEMUCB\Caroline_200.csv';
fn16 = 'conduit_major\SEMUCB\Juan_Fer_200.csv';
fn17 = 'conduit_major\SEMUCB\San_Felix_200.csv';
fn18 = 'conduit_major\SEMUCB\Marion_200.csv';
fn19 = 'conduit_major\SEMUCB\Meteor_200.csv';
fn20 = 'conduit_major\SEMUCB\Vema_200.csv';
fn21 = 'conduit_major\SEMUCB\Trindade_200.csv';
fn22 = 'conduit_major\SEMUCB\St_H_200.csv';
fn23 = 'conduit_major\SEMUCB\Cape_200.csv';
fn24 = 'conduit_major\SEMUCB\Canary_200.csv';
fn25 = 'conduit_major\SEMUCB\Azores_200.csv';
% fn26 = 'conduit_major\JM_200_g.csv';
fn27 = 'conduit_major\SEMUCB\Hoggar_200.csv';
% fn28 = 'conduit_major\SEMUCB\Fernando_200.csv';

% x, y, z [0,1]
f1 = readmatrix(fn1);f2 = readmatrix(fn2);
f3 = readmatrix(fn3);f4 = readmatrix(fn4);
f5 = readmatrix(fn5);f6 = readmatrix(fn6);
f7 = readmatrix(fn7);f8 = readmatrix(fn8);
f9 = readmatrix(fn9);f10 = readmatrix(fn10);
f11 = readmatrix(fn11);f12 = readmatrix(fn12);
f13 = readmatrix(fn13);f14 = readmatrix(fn14);
f15 = readmatrix(fn15);f16 = readmatrix(fn16);
f17 = readmatrix(fn17);f18 = readmatrix(fn18);
f19 = readmatrix(fn19);f20 = readmatrix(fn20);
f21 = readmatrix(fn21);f22 = readmatrix(fn22);
f23 = readmatrix(fn23);f24 = readmatrix(fn24);
f25 = readmatrix(fn25);
% f26 = readmatrix(fn26);
f27 = readmatrix(fn27);
% f28 = readmatrix(fn28);

%%
clear all
% load glad-m25
fn1 = 'conduit_major\Glad-m25\EAR_200_g.csv';
fn2 = 'conduit_major\Glad-m25\Easter_200_g.csv';
fn3 = 'conduit_major\Glad-m25\Iceland_200_g.csv';
fn4 = 'conduit_major\Glad-m25\Tristan_200_g_2.csv';
fn5 = 'conduit_major\Glad-m25\Louisville_200_g.csv';
fn6 = 'conduit_major\Glad-m25\Reunion_200_g.csv';
fn7 = 'conduit_major\Glad-m25\Hawaii_200_g.csv';
fn8 = 'conduit_major\Glad-m25\Samoa_200_g.csv';
fn9 = 'conduit_major\Glad-m25\Tahiti_200_g.csv';
fn10 = 'conduit_major\Glad-m25\Mac_200_g.csv';
fn11 = 'conduit_major\Glad-m25\Pitcairn_200_g.csv';
fn12 = 'conduit_major\Glad-m25\Gala_200_g.csv';
fn13 = 'conduit_major\Glad-m25\Marquesas_200_g.csv';
fn14 = 'conduit_major\Glad-m25\Kerguelen_200_g.csv';
fn15 = 'conduit_major\Glad-m25\Caroline_200_g.csv';
fn16 = 'conduit_major\Glad-m25\Juan_Fer_200_g.csv';
fn17 = 'conduit_major\Glad-m25\San_Felix_200_g.csv';
fn18 = 'conduit_major\Glad-m25\Marion_200_g.csv';
fn19 = 'conduit_major\Glad-m25\Meteor_200_g.csv';
fn20 = 'conduit_major\Glad-m25\Vema_200_g.csv';
fn21 = 'conduit_major\Glad-m25\Trindade_200_g.csv';
fn22 = 'conduit_major\Glad-m25\St_H_200_g.csv';
fn23 = 'conduit_major\Glad-m25\Cape_200_g.csv';
fn24 = 'conduit_major\Glad-m25\Canary_200_g.csv';
fn25 = 'conduit_major\Glad-m25\Azores_200_g.csv';
fn26 = 'conduit_major\Glad-m25\JM_200_g.csv';
fn27 = 'conduit_major\Glad-m25\Hoggar_200_g.csv';
fn28 = 'conduit_major\Glad-m25\Fernando_200_g.csv';

f1 = readmatrix(fn1);f2 = readmatrix(fn2);
f3 = readmatrix(fn3);f4 = readmatrix(fn4);
f5 = readmatrix(fn5);f6 = readmatrix(fn6);
f7 = readmatrix(fn7);f8 = readmatrix(fn8);
f9 = readmatrix(fn9);f10 = readmatrix(fn10);
f11 = readmatrix(fn11);f12 = readmatrix(fn12);
f13 = readmatrix(fn13);f14 = readmatrix(fn14);
f15 = readmatrix(fn15);f16 = readmatrix(fn16);
f17 = readmatrix(fn17);f18 = readmatrix(fn18);
f19 = readmatrix(fn19);f20 = readmatrix(fn20);
f21 = readmatrix(fn21);f22 = readmatrix(fn22);
f23 = readmatrix(fn23);f24 = readmatrix(fn24);
f25 = readmatrix(fn25);f26 = readmatrix(fn26);
f27 = readmatrix(fn27);f28 = readmatrix(fn28);

