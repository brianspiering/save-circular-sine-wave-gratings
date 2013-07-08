%% Save circular sine-wave grating
% Typically circular sine-wave grating are used within Psychophysics Toolbox.
% This programs helps when working outside of Psychophysics Toolbox, 
% e.g., when collaborating or making figures for papers or figures.
% It assumes generation of values, see Ashby & Gott, 1988

% Dr. Brian J. Spiering, 07/06/13

%% General Setup
clear all
close all
clc

%% Load Files
load meshX.dat -ascii        % I forgot what exactly this file is
load meshY.dat -ascii        % I forgot what exactly this file is
load circlespace.dat -ascii  % I forgot what exactly this file is

%% Define stimuli
stimuli = [1.0000    0.1460    1.8809]; % [category_membership bar_width_in_cycles_per_visual_angle  bar_tilt_in_radians]
title_string = ['disc_' num2str(round(stimuli(2)*1000)/1000) 'width_' num2str(round(stimuli(3)*1000)/1000) 'tilt'];

%% Define Colors
black = 0;	
white = 64;
grey = (white+black)/2;
color_scalar = white-grey;
map = colormap(gray); % use linear grey-scale color map.
close % close the unneeded colormap figure

for trial = 1:size(stimuli,1)
    
	%% Define Variables
	category_membership = stimuli(trial,1);
    spatial_frequency = stimuli(trial,2);
    orientation = stimuli(trial,3);
    	
	%% Create disc
    figure('Position',[30 24 400 300]);
	g = cos(orientation)*spatial_frequency;
	h = sin(orientation)*spatial_frequency;
	wave = sin(h*meshX+g*meshY);
	raw_disc = circlespace.*wave;
	imagedisc = grey+color_scalar*raw_disc;
	
    %% Make sure there is an images folder
    if (isdir([cd '/images']) == 0)
        mkdir('images')
    end

    %% Write the file
    file_name = [cd '/images/' title_string '.tiff'];
    imwrite(imagedisc,map,file_name,'tiff');
    close;
end

disp('Images generated and saved.');