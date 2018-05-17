

clc;				% Clear command window.
clear;				% Delete all variables.
close all;			% Close all figure windows except those created by imtool.
imtool close all;	% Close all figure windows created by imtool.
workspace;			% Make sure the workspace panel is showing.
fontSize = 15;

% Read in a standard MATLAB gray scale demo image.

global im;
global filename;

folder = fullfile(matlabroot, '\toolbox\images\imdemos');

baseFileName = filename;

% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
if ~exist(fullFileName, 'file')

	fullFileName = baseFileName; % No path this time.
	if ~exist(fullFileName, 'file')

		errorMessage = sprintf('Error: %s does not exist.', fullFileName);
		uiwait(warndlg(errorMessage));
		return;
	end
end
grayImage = imread(fullFileName);

% Get the dimensions of the image.  numberOfColorBands should be = 1.
[rows, columns, numberOfColorBands] = size(grayImage);

% Display the original gray scale image.
subplot(2, 2, 1);
imshow(grayImage, []);
title('Original Grayscale Image', 'FontSize', fontSize);

% Enlarge figure to full screen.
% set(gcf, 'Position', get(0,'Screensize')); 
set(gcf,'name','Image Analysis Demo','numbertitle','off') 

% uiwait(msgbox('Click a point'));
[x, y] = ginput(1);
row = max([int32(y) 1]);
column = max([int32(x) 1]);

% Get the gray level of the point they clicked on.
grayLevel = grayImage(row, column);
tolerance = 10;

% Construct abinary image within the gray level tolerance of where they clicked.
lowGL = grayLevel - tolerance;
highGL = grayLevel + tolerance;
% [(grayImage-tolerance),(grayImage+tolerance)]

binaryImage = (grayImage >= lowGL)&(grayImage <= highGL);

subplot(2, 2, 2);
imshow(binaryImage, []);
caption = sprintf('Binary Image within \n+/- %d Gray Levels of %d', ...
	tolerance, grayLevel);
title(caption, 'FontSize', fontSize);

msgbox('Done with demo magic wand');
gui