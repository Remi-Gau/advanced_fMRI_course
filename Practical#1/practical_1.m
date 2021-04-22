%% Reading header information
% The easy way to do this is to go to the directory where the structural is
% and type:
HeaderStructural = spm_vol('sM00223_002.img');

% But below is another way to do it that is more 'automatic'.

clear all; % Clears all the variable that are present in matlab's memory (the 'workspace')
clc; % Removes all the ouput that are present on the command line screen

% Get a name to the starting folder and stores it in a variable
StartFolder = pwd; % pwd --> Present Working Directory

% Defines a variable containing the name of the folder containg the
% structural scan.
StructuralFolder = fullfile(StartFolder, 'MoAEpilot', 'sM00223');

% Finding out the name of the strucural
% First got to the director where the structural scan is
cd(StructuralFolder); % cd --> Change Directory

% List all the images starting with an s and ending with the extension .img
% Easy: there is only one)
FilesList = dir('s*.img');

% Read the content of the header and stores it in a variable
HeaderStructural = spm_vol(FilesList.name);

%% Reading header information: some specifics
% Get the number of slices: slices were acquired axially that is along the
% Z dimension. The third value of the dimension matrix tells us the number
% of voxels along the Z axis, i.e the number of slices
Number_Of_Slices = HeaderStructural.dim(3);

% Get the dimension of each slice: defined as the dimension of the matrix along
% the X and Y-axis
SliceDimension = HeaderStructural.dim(1:2);

% Gets the Voxel space to World space transformation matrix of this image
TransformationMatrix = HeaderStructural.mat;
% or
TransformationMatrix = spm_get_space(FilesList.name);

% The dimension of each voxel are the 3 first values of the main diagonal of this matrix
% Get the value along the main diagonal of the matrix and stores it in a
% temporary variable
temp = diag(TransformationMatrix);
% Then we only keep the 3 first values of this diagonal to get the x,y,z dimension
% of each voxel (in mm) of this image ; the "abs" is there to have the
% absolute value
VoxelsDimension = abs(temp(1:3));

% Getting the world space coordinate of a given voxel
VoxelSubscripts = [1 1 1];
% We have to take the transpose (') of the voxel indices vector and pad it with an
% extra one to be able to multiply it with the tranformation matrix.
temp = [VoxelSubscripts'; 1];
WorldSpaceCoordinates = TransformationMatrix * temp;
% Only the three first value of this vector are of interest to us
WorldSpaceCoordinates = WorldSpaceCoordinates(1:3);

% Getting the voxel subscripts of a given set of world space coordinates
WorldSpaceCoordinates = [0 0 0];
% Remember that if a matrix A performs a certain transformation, the matrix inv(A) will
% perform the reverse transfomation
VoxelSubscripts = inv(TransformationMatrix) * [WorldSpaceCoordinates'; 1];
VoxelSubscripts = round(VoxelSubscripts(1:3)); % we need to use 'round' to get a value that
% is not in between 2 voxels.

cd(StartFolder);

%% Reading values from an image
clear all;
clc;

% Given some coordinates. Here I chose a voxel that is roughly in the left Heschl's gyrus
WorldSpaceCoordinates = [47 33 35];

% List the EPI images
StartFolder = pwd;
EPI_Folder = fullfile(StartFolder, 'MoAEpilot', 'fM00223');
cd(EPI_Folder);

% List all the realigned images in this folder: here the "u" prefix
% could be used if you did realign and unwarp step. Usually the
% realign:estimate and write, will add the prefix "r", though this default can be
% changed easily.
FilesList = dir('f*.img');

% Read the content of the header of the first image and stores it in a variable
HeaderEPI = spm_vol(FilesList(1).name);

% Gets the data corresponding to this image
Volume = spm_read_vols(HeaderEPI);

% Compute thevoxel indices corresponding to our real world coordinates
Transf_matrix = spm_get_space(FilesList(1).name);
WorldSpaceCoordinates = [WorldSpaceCoordinates 1];
VoxelSubscripts = inv(Transf_matrix) * WorldSpaceCoordinates';
% We round those values to the nearest integer values: subscripts have to be
% integers. Also we only take the 3 first values (the last value is a 1
% just there for padding).
VoxelSubscripts = round(VoxelSubscripts);
VoxelSubscripts = VoxelSubscripts(1:3);

% Get the signal intensity value at our voxel of interest
Volume(VoxelSubscripts(1), VoxelSubscripts(2), VoxelSubscripts(3));

% Note that the function spm_sample_vol can give you the value of a given
% voxel and does not require integer subscripts values: it will
% give you the interpolated intensity value at the exact location you
% required.

cd(StartFolder);

%% Reading a time-series
clear all;
clc;

% Given some coordinates. Here I chose a voxel that is roughly in the left Heschl's gyrus
WorldSpaceCoordinates = [47 33 35];

% Get to the right folder
StartFolder = pwd;
EPI_Folder = fullfile(StartFolder, 'MoAEpilot', 'fM00223');
cd(EPI_Folder);

% -------------------------------------------------------------------------%
%% Open all the images with a loop
% -------------------------------------------------------------------------%
tic; % The tic toc fucntion call help decide which methods is quicker.
% the function 'length' will tell you how many items there are in a vector,
% matrix, structure...

ImageName = dir('wf*.img'); % Here I am reading the normalised images

% Get the voxel coordinates.
Transf_matrix = spm_get_space(ImageName(1).name);
WorldSpaceCoordinates = [WorldSpaceCoordinates 1];
VoxelSubscripts = inv(Transf_matrix) * WorldSpaceCoordinates';
VoxelSubscripts = round(VoxelSubscripts);

for ImageIndex = 1:length(ImageName)
    % Open the header of a given image
    ImgInfo = spm_vol(ImageName(ImageIndex).name);
    % Adds it data at the end of a 4D matrix
    Volume(:, :, :, ImageIndex) = spm_read_vols(ImgInfo);
end
% -------------------------------------------------------------------------%

% Read the time serie at the voxel coordinate we want across the 4th
% dimension (time) of our matrice
TimeCourse = Volume(VoxelSubscripts(1), VoxelSubscripts(2), VoxelSubscripts(3), :);
% We use the squeeze function to get rid of the 3 first "empty" dimensions
% of our time course.
TimeCourse = squeeze(TimeCourse);

toc;

% -------------------------------------------------------------------------%
%% Open all the images at once
% -------------------------------------------------------------------------%
tic;

% Creates a matrix with all the names of the images
ImageName = dir('wf*.img');
% Or use the spm_select function (but that's almost cheating !)
% ImagesName=spm_select(Inf, 'image');

% Get the voxel coordinates.
Transf_matrix = spm_get_space(ImageName(1).name);
WorldSpaceCoordinates = [WorldSpaceCoordinates 1];
VoxelSubscripts = inv(Transf_matrix) * WorldSpaceCoordinates';
VoxelSubscripts = round(VoxelSubscripts);

% Get all the headers
ImagesName = char({ImageName.name}');
ImgInfo = spm_vol(ImagesName);
% Open all the images
Volume = spm_read_vols(ImgInfo);

TimeCourse = Volume(VoxelSubscripts(1), VoxelSubscripts(2), VoxelSubscripts(3), :);
TimeCourse = squeeze(TimeCourse);

toc;

% -------------------------------------------------------------------------%
%% Use the SPM built in function
% -------------------------------------------------------------------------%
tic;

% List the images
ImageName = dir('wf*.img');
ImagesName = char({ImageName.name}');

% Get the voxel coordinates.
Transf_matrix = spm_get_space(ImageName(1).name);
WorldSpaceCoordinates = [WorldSpaceCoordinates 1];
VoxelSubscripts = inv(Transf_matrix) * WorldSpaceCoordinates';

% Reads the data
TimeCourse = spm_get_data(ImagesName, VoxelSubscripts(1:3));

toc;

% Another advantage of this method is that spm_get_data accepts non
% integer voxel subscripts and can get the data for several voxels at
% once.

%% Plot the result
figure('Name', sprintf('Signal time course at the voxel coordinates X= %i, Y=%i, Z=%i', ...
                       VoxelSubscripts(1), VoxelSubscripts(2), VoxelSubscripts(3)), ...
       'Color', 'w');

plot(TimeCourse);

ylabel('Signal Intensity');
xlabel('Scan number');

cd(StartFolder);

%% Estimate how misaligned are the 2 first volumes using a least-square estimate
clear all;
clc;

StartFolder = pwd;
EPI_Folder = fullfile(StartFolder, 'MoAEpilot', 'fM00223');
cd(EPI_Folder);

ImageName = dir('fM*.img');

% Gets the first volume
ImgInfo = spm_vol(ImageName(1).name);
Volume_1 = spm_read_vols(ImgInfo);

% Create a volume where all the values of the volume 1 have a signal 10%
% higher than that of volume 1
Volume_1_offset = Volume_1 + mean(Volume_1(:)) * 10 / 100;

% Create a volume similar to the volume 1 but with random noise added.
% Here I add gaussian noise with a standart deviation equals to that of the
% whole image that I compute with the 'std' function
Volume_1_noise = Volume_1 + randn(size(Volume_1)) * std(Volume_1(:));
% Let's keep the absolute values to make sure that we do not have any
% negative intensities
Volume_1_noise = abs(Volume_1_noise);

% Create a volume that is the negative of volume 1
Volume_1_invert = -Volume_1 + max(Volume_1(:));

% Estimating misalignment using a least-square estimate
% Since the 'sum' function works along a single dimension, a quick and
% dirty wayt to
Least_Squares(1) = sum(sum(sum((Volume_1 - Volume_1).^2)));
Least_Squares(end + 1) = sum(sum(sum((Volume_1 - Volume_1_offset).^2)));
Least_Squares(end + 1) = sum(sum(sum((Volume_1 - Volume_1_noise).^2)));
Least_Squares(end + 1) = sum(sum(sum((Volume_1 - Volume_1_invert).^2)));

% Estimating misalignment using a using normalized correlation
Normalized_Correlation(1) = sum(sum(sum(Volume_1 .* Volume_1))) / ...
                (sqrt(sum(Volume_1(:).^2)) * sqrt(sum(Volume_1(:).^2)));

Normalized_Correlation(end + 1) = sum(sum(sum(Volume_1 .* Volume_1_offset))) / ...
                (sqrt(sum(Volume_1(:).^2)) * sqrt(sum(Volume_1_offset(:).^2)));

Normalized_Correlation(end + 1) = sum(sum(sum(Volume_1 .* Volume_1_noise))) / ...
                (sqrt(sum(Volume_1(:).^2)) * sqrt(sum(Volume_1_noise(:).^2)));

Normalized_Correlation(end + 1) = sum(sum(sum(Volume_1 .* Volume_1_invert))) / ...
                (sqrt(sum(Volume_1(:).^2)) * sqrt(sum(Volume_1_invert(:).^2)));

cd(StartFolder);

%% Generating coregistration histograms

figure('Name', 'Coregistration histograms Volume 1 and Volume 1', 'Color', 'w');
scatter(Volume_1(:), Volume_1(:), 'k', '.');
xlabel('Intensities image 1');
ylabel('Intensities image 2');
axis square;

figure('Name', 'Coregistration histograms Volume 1 and Volume 1 offseted', 'Color', 'w');
scatter(Volume_1(:), Volume_1_offset(:), 'k', '.');
xlabel('Intensities image 1');
ylabel('Intensities image 1 offseted');
axis square;

figure('Name', 'Coregistration histograms Volume 1 and Volume 1 with noise', 'Color', 'w');
scatter(Volume_1(:), Volume_1_noise(:), 'k', '.');
xlabel('Intensities image 1');
ylabel('Intensities image 1 with noise');
axis square;

figure('Name', 'Coregistration histograms Volume 1 and Volume 1 inverted', 'Color', 'w');
scatter(Volume_1(:), Volume_1_invert(:), 'k', '.');
xlabel('Intensities image 1');
ylabel('Intensities image 1 inverted');
axis square;

%% Reading values within a region of interest
clear all;
clc;

% Naming folders
StartFolder = pwd;
EPI_Folder = fullfile(StartFolder, 'MoAEpilot', 'fM00223');
Masks_Folder = fullfile(StartFolder, 'Masks');

% Get the value of the 2 masks
cd(Masks_Folder);
% We use the function logical to make sure that that the values in the
% masks are either 1 or 0;
Left_A1_Mask = logical(spm_read_vols(spm_vol('rwLeft_A1.hdr')));
Right_A1_Mask = logical(spm_read_vols(spm_vol('rwRight_A1.hdr')));

% List all the realigned images
cd(EPI_Folder);
ImageName = dir('f*.img');
ImagesName = char({ImageName.name}');

%% Open all the images and loop through them to average each one
% Get all the headers
ImgInfo = spm_vol(ImagesName);
% Open all the images
Volume = spm_read_vols(ImgInfo);

for ImageIndex = 1:size(ImageName, 2)
    % Get the average signal value in the ROIs
    TimeCourseLeft(ImageIndex) = mean(Volume(Left_A1_Mask));
    TimeCourseRight(ImageIndex) = mean(Volume(Right_A1_Mask));
end

%% Use the SPM built-in function
% Before doing that we need to know the x, y and z subscripts of each
% voxel of a given ROI.
tmp = find(Left_A1_Mask);
[X, Y, Z] = ind2sub(size(Left_A1_Mask), tmp);
clear tmp;
% Then we can use the spm_get_data function
TimeCourseLeft = spm_get_data(ImagesName, [X Y Z]');
% Then we average over voxels (i.e across columns of the TimeCourseLeft
% variable)
TimeCourseLeft = mean(TimeCourseLeft, 2);

% Ditto for the other ROI
tmp = find(Right_A1_Mask);
[X, Y, Z] = ind2sub(size(Right_A1_Mask), tmp);
clear tmp;
TimeCourseRight = spm_get_data(ImagesName, [X Y Z]');
TimeCourseRight = mean(TimeCourseRight, 2);

%% Plot the results
figure('Name', 'Signal time in each primary auditory cortices', 'Color', 'w');
hold on;
plot(TimeCourseLeft, 'b');
plot(TimeCourseRight, 'r');

ylabel('Signal Intensity');
xlabel('Scan number');

legend(char({'Left'; 'Right'}));

cd(StartFolder);

%% Applying affine transformations to an image
clear all;
clc;

StartFolder = pwd;
StructuralFolder = fullfile(StartFolder, 'MoAEpilot', 'sM00223');
cd(StructuralFolder);
FilesList = dir('sM00223_002.img');

HeaderStructural = spm_vol(FilesList.name);
TransformationMatrix = HeaderStructural.mat;
Volume = spm_read_vols(HeaderStructural);

% TRANSLATION
% Creates the vector needed for the spm_matrix function
P_translation = zeros(12, 1);
P_translation(1) = 14;
P_translation(2) = -58;
P_translation(3) = 65;
% Creates the translation matrix
Translation = spm_matrix(P_translation, 'T');
% Applies it to the transformation matrix
TransformationMatrix_Translation = Translation * TransformationMatrix;

% getting the header information of the original image
HeaderStructural_Translated = HeaderStructural;

% and change the name and the transformation matrix in the header
HeaderStructural_Translated.fname = 'Structural_Translated.img';
HeaderStructural_Translated.private.dat.fname = HeaderStructural_Translated.fname;
HeaderStructural_Translated.mat = TransformationMatrix_Translation;

spm_write_vol(HeaderStructural_Translated, Volume);

% ROTATION
% Creates the rotation matrix: spm works with radians, so if you want to
% rotate the image by 90 degrees you have to transform it to radians first.
P_rotation = zeros(12, 1);
P_rotation(4) = 90 * pi / 180;
Rotation = spm_matrix(P_rotation, 'R');

TransformationMatrix_Rotation = Rotation * TransformationMatrix;

% getting the header information of the original image
HeaderStructural_Rotated = HeaderStructural;

% and change the name and the transformation matrix in the header
HeaderStructural_Rotated.fname = 'Structural_Rotated.img';
HeaderStructural_Rotated.private.dat.fname = HeaderStructural_Rotated.fname;
HeaderStructural_Rotated.mat = TransformationMatrix_Rotation;

spm_write_vol(HeaderStructural_Rotated, Volume);

cd(StartFolder);
