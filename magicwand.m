

clc;	% Clear command window.
clear;	% Delete all variables.
close all;	% Close all figure windows except those created by imtool.
imtool close all;	% Close all figure windows created by imtool.
workspace;	% Make sure the workspace panel is showing.
fontSize = 15;
% Read in a standard MATLAB gray scale demo image.

global im;
global filename;

folder = fullfile(matlabroot, '\toolbox\images\imdemos');

baseFileName = filename;
% baseFileName = im;

% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
if ~exist(fullFileName, 'file')
	% Didn't find it there.  Check the search path for it.
	fullFileName = baseFileName; % No path this time.
	if ~exist(fullFileName, 'file')
		% Still didn't find it.  Alert user.
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
set(gcf, 'Position', get(0,'Screensize')); 
set(gcf,'name','Image Analysis Demo','numbertitle','off') 

% uiwait(msgbox('Click a point'));
[x, y] = ginput(1);
row = max([int32(y) 1]);
column = max([int32(x) 1]);
% Get the gray level of the point they clicked on.
grayLevel = grayImage(row, column);
tolerance = 10;

% Construct abinary image within the gray level tolerance 
% of where they clicked.
lowGL = grayLevel - tolerance;
highGL = grayLevel + tolerance;
binaryImage = grayImage >= lowGL & grayImage <= highGL;
subplot(2, 2, 2);
imshow(binaryImage, []);
caption = sprintf('Binary Image within \n+/- %d Gray Levels of %d', ...
	tolerance, grayLevel);
title(caption, 'FontSize', fontSize);

% Get a marker image to reconstruct just the connected region
% and not all the other disconnected regions.
% binaryMarkerImage = false(rows, columns);
% binaryMarkerImage(row, column) = true;
% 
% outputImage = imreconstruct(binaryMarkerImage, binaryImage);
% subplot(2, 2, 3);
% imshow(outputImage, []);
% title('Magic Wand Reconstructed Binary Image', 'FontSize', fontSize);

% Get the masked image - the original image in the region.
% maskedImage = zeros(rows, columns, 'uint8');
% maskedImage(outputImage) = grayImage(outputImage);
% subplot(2, 2, 4);
% imshow(maskedImage, [0 255]);
% title('Magic Wand Grayscale Image', 'FontSize', fontSize);

msgbox('Done with demo magic wand');
gui