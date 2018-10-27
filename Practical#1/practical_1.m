%% Reading header information
% The easy way to do this is to go to the directory where the structural is
% and type: HeaderStructural = spm_vol('sM00223_002.img');

% But below is another way to do it that is more 'automatic'.

clear all; % Clears all the variable that are present in matlab's memory (the 'workspace')
clc; % Removes all the ouput that are present on the command line screen

% Get a name to the starting folder and stores it in a variable
StartFolder = pwd; % pwd --> Present Working Directory

% Defines a variable containing the name of the folder containg the
% structural scan. This suppose you have stored the files in a folder called 'BlockDesign' and
% renamed 'Structural' the folder containing the strucural
StructuralFolder = fullfile(StartFolder, 'BlockDesign', 'Structural');

% Finding out the name of the strucural
% First got to the director where the structural scan is
cd(StructuralFolder) % cd --> Change Directory
% List all the images starting with an s and ending with the extension .img 
% Easy: there is only.
% one)
FilesList = dir('s*.img');

% Read the content of the header and stores it in a variable
HeaderStructural = spm_vol(FilesList.name);



%% Reading header information: some specifics
% Get the number of slices: slices were acquired axially that is along the 
% Z dimension. The third value of the dimension matrix tells us the number 
% of voxels along the Z axis, i.e the number of slices
Number_Of_Slices = HeaderStructural.dim(3)

% Get the dimension of each slice: defined as the dimension of the matrix along
% the X and Y-axis
SliceDimension = HeaderStructural.dim(1:2)

% Gets the Voxel space to World space transformation matrix of this image
TransformationMatrix = HeaderStructural.mat
% or
TransformationMatrix = spm_get_space(FilesList.name)

% The dimension of each voxel are the 3 first values of the main diagonal of this matrix
% Get the value along the main diagonal of the matrix and stores it in a
% temporary variable
temp = diag(TransformationMatrix);
% Then we only keep the 3 first values of this diagonal to get the x,y,z dimension
% of each voxel (in mm) of this image ; the "abs" is there to have the
% absolute value
VoxelsDimension = abs(temp(1:3))

% Getting the world space coordinate of a given voxel
VoxelIndices = [1 1 1];
% We have to take the transpose (') of the voxel indices vector and pad it with an
% extra one to be able to multiply it with the tranformation matrix.
temp = [VoxelIndices' ; 1];
WorldSpaceCoordinates = TransformationMatrix * temp;
% Only the three first value of this vector are of interest to us
WorldSpaceCoordinates = WorldSpaceCoordinates(1:3)

% Getting the voxel indices of a given set of world space coordinates 
WorldSpaceCoordinates = [0 0 0];
% Remember that if a matrix A performs a certain transformation, the matrix inv(A) will
% perform the reverse transfomation
VoxelIndices = inv(TransformationMatrix)*[WorldSpaceCoordinates' ; 1];
VoxelIndices = VoxelIndices(1:3)

cd(StartFolder)



%% Reading values from an image
clear all; clc

% Name of the starting folder
StartFolder = pwd;

% Given some coordinates
WorldSpaceCoordinates = [47 33 35];

% Name of the folder containg the structural scan
EPI_Folder = fullfile(StartFolder, 'BlockDesign', 'EPI');

% Finding out the name of the strucural
cd(EPI_Folder)
FilesList = dir('f*.img');

% Read the content of the header and stores it in a variable
HeaderEPI = spm_vol(FilesList(1).name);

% Gets the data corresponding to this image
Volume = spm_read_vols(HeaderEPI);

% Compute thevoxel indices corresponding to our real world coordinates
Transf_matrix = spm_get_space(FilesList(1).name);
WorldSpaceCoordinates = [WorldSpaceCoordinates 1];
VoxelIndices = inv(Transf_matrix)*WorldSpaceCoordinates';
% We round those values to the neasrest integer values: indices have to be
% integers
VoxelIndices = round(VoxelIndices);
VoxelIndices = VoxelIndices(1:3);

Volume(VoxelIndices(1), VoxelIndices(2), VoxelIndices(3))

cd(StartFolder)



%% Reading a time-series
clear all; clc

% Name of the starting folder
StartFolder = pwd;

% Here I chose a voxel that is roughly in the left Heschl's gyrus
WorldSpaceCoordinates = [47 33 35];

% Name of the folder containg the structural scan
EPI_Folder = fullfile(StartFolder, 'BlockDesign', 'EPI');

cd(EPI_Folder)

% List all the realigned images in this folder: here I used a "u" prefix
% because I used the realign and unwarp function. Usually the
% realign:estimate and write, will add the prefix "r", though this can be
% changed easily.
ImageName = dir('u*.img');

% Get the voxel indices of our world space coordinate
% Since our images have same dimension and same transformation matrices 
% (since they all have been realigned), so getting the transformation 
% matrix of the first one will do.
Transf_matrix = spm_get_space(ImageName(1).name);
WorldSpaceCoordinates = [WorldSpaceCoordinates 1];
VoxelIndices = inv(Transf_matrix)*WorldSpaceCoordinates';
VoxelIndices = round(VoxelIndices);


%-------------------------------------------------------------------------%
% Open all the images with a loop
%-------------------------------------------------------------------------%
%the function 'length' will tell you how many items there are in a vector,
%matrix, structure...
for ImageIndex = 1:length(ImageName) 
    % Open the header of a given image
    ImgInfo = spm_vol(ImageName(ImageIndex).name);
    % Adds it data at the end of a 4D matrix
    Volume(:,:,:,ImageIndex) = spm_read_vols(ImgInfo);
end
%-------------------------------------------------------------------------%


%-------------------------------------------------------------------------%
% Open all the images at once
%-------------------------------------------------------------------------%
% Creates a matrix with all the names of the images
ImagesName = char({ImageName.name}');
% Or use the spm_select function (but that's almost cheating !)
ImagesName=spm_select(Inf, 'image');
% Get all the headers
ImgInfo = spm_vol(ImagesName);
% Open all the iamges
Volume = spm_read_vols(ImgInfo);
%-------------------------------------------------------------------------%

% Read the time serie at the voxel coordinate we want across the 4th
% dimension (time) of our matrice 
TimeCourse = Volume(VoxelIndices(1), VoxelIndices(2), VoxelIndices(3), :);
% We use the squeeze function to get rid of the 3 first "empty" dimensions
% of our time course.
TimeCourse = squeeze(TimeCourse);

figure('Name', sprintf('Signal time course at the voxel coordinates X= %i, Y=%i, Z=%i', ...
       VoxelIndices(1), VoxelIndices(2), VoxelIndices(3)), ...
       'Color', 'w')
   
plot(TimeCourse)

ylabel('Signal Intensity')
xlabel('Scan number')


cd(StartFolder)



%% Estimate how misaligned are the 2 first volumes using a least-square estimate 
% Do it with a ROI of auditory cortex
clear all; clc

% Name of the starting folder
StartFolder = pwd;

% Name of the folder containg the structural scan
EPI_Folder = fullfile(StartFolder, 'BlockDesign', 'EPI');

cd(EPI_Folder)

% List all the raw images
ImageName = dir('fM*.img');


% Gets the first volume
ImgInfo = spm_vol(ImageName(1).name);
Volume_1 = spm_read_vols(ImgInfo);

% Create a volume where all the values of the volume 1 have a signal 10%
% higher than that of volume 1
Volume_1_offset = Volume_1 + mean(Volume_1(:))*10/100;

% Create a volume similar to the volume 1 but with random noise added.
% Here I add gaussian noise with a standart deviation equals to that of the
% whole image that I compute with the 'std' function
Volume_1_noise = Volume_1+randn(size(Volume_1))*std(Volume_1(:));
% Let's keep the absolute values to make sure that we do not have any
% negative intensities
Volume_1_noise = abs(Volume_1_noise);

% Create a volume that is the negative of volume 1
Volume_1_invert = -Volume_1+max(Volume_1(:));


% Gets the second volume
ImgInfo = spm_vol(ImageName(2).name);
Volume_2 = spm_read_vols(ImgInfo);

% List all the raw images
ImageName = dir('ufM*.img');
ImgInfo = spm_vol(ImageName(2).name);
Volume_2_realigned = spm_read_vols(ImgInfo);


% Estimating misalignment using a least-square estimate
% Since the 'sum' function works along a single dimension, a quick and
% dirty wayt to
Least_Squares(1) = sum(sum(sum( (Volume_1 - Volume_1).^2) ));
Least_Squares(2) = sum(sum(sum( (Volume_1 - Volume_2).^2) ));
Least_Squares(3) = sum(sum(sum( (Volume_1 - Volume_2_realigned).^2) ));
Least_Squares(4) = sum(sum(sum( (Volume_1 - Volume_1_offset).^2) ));
Least_Squares(5) = sum(sum(sum( (Volume_1 - Volume_1_noise).^2)) );
Least_Squares(6) = sum(sum(sum( (Volume_1 - Volume_1_invert).^2) ))


% Estimating misalignment using a using normalized correlation
Normalized_Correlation(1) = sum(sum(sum(Volume_1.*Volume_1))) / ...
                ( sqrt(sum((Volume_1(:).^2))) * sqrt(sum(Volume_1(:).^2)) );
            
Normalized_Correlation(2) = sum(sum(sum(Volume_1.*Volume_2))) / ...
                ( sqrt(sum((Volume_1(:).^2))) * sqrt(sum((Volume_2(:).^2))) );
            
Normalized_Correlation(3) = sum(sum(sum(Volume_1.*Volume_2_realigned))) / ...
                ( sqrt(sum((Volume_1(:).^2))) * sqrt(sum((Volume_2_realigned(:).^2))) );            
            
Normalized_Correlation(4) = sum(sum(sum(Volume_1.*Volume_1_offset))) / ...
                ( sqrt(sum((Volume_1(:).^2))) * sqrt(sum((Volume_1_offset(:).^2))) );
            
Normalized_Correlation(5) = sum(sum(sum(Volume_1.*Volume_1_noise))) / ...
                ( sqrt(sum((Volume_1(:).^2))) * sqrt(sum((Volume_1_noise(:).^2))) );
            
Normalized_Correlation(6) = sum(sum(sum(Volume_1.*Volume_1_invert))) / ...
                ( sqrt(sum((Volume_1(:).^2))) * sqrt(sum((Volume_1_invert(:).^2))) )           

            
cd(StartFolder)



%% Generating coregistration histograms
figure('Name', 'Coregistration histograms Volume 1 and Volume 1', 'Color', 'w')
scatter(Volume_1(:), Volume_1(:), 'k', '.');
xlabel('Intensities image 1')
ylabel('Intensities image 2')
axis square

figure('Name', 'Coregistration histograms Volume 1 and Volume 2', 'Color', 'w')
scatter(Volume_1(:), Volume_2(:), 'k', '.');
xlabel('Intensities image 1')
ylabel('Intensities image 2')
axis square

figure('Name', 'Coregistration histograms Volume 1 and Volume 2 realigned', 'Color', 'w')
scatter(Volume_1(:), Volume_2_realigned(:), 'k', '.');
xlabel('Intensities image 1')
ylabel('Intensities image 2 realigned')
axis square

figure('Name', 'Coregistration histograms Volume 1 and Volume 1 offseted', 'Color', 'w')
scatter(Volume_1(:), Volume_1_offset(:), 'k', '.');
xlabel('Intensities image 1')
ylabel('Intensities image 1 offseted')
axis square

figure('Name', 'Coregistration histograms Volume 1 and Volume 1 with noise', 'Color', 'w')
scatter(Volume_1(:), Volume_1_noise(:), 'k', '.');
xlabel('Intensities image 1')
ylabel('Intensities image 1 with noise')
axis square

figure('Name', 'Coregistration histograms Volume 1 and Volume 1 inverted', 'Color', 'w')
scatter(Volume_1(:), Volume_1_invert(:), 'k', '.');
xlabel('Intensities image 1')
ylabel('Intensities image 1 inverted')
axis square



%% Reading values within a region of interest
clear all; clc

% Name of the starting folder
StartFolder = pwd;

% Name of the folder containg the images
EPI_Folder = fullfile(StartFolder, 'BlockDesign', 'EPI');
Masks_Folder = fullfile(StartFolder, 'Masks');

% Get the value of the 2 masks
cd(Masks_Folder)
% We use the function logical to make sure that that the values in the
% masks are either 1 or 0;
Left_A1_Mask = logical(spm_read_vols(spm_vol('rwLeft_A1.hdr')));
Right_A1_Mask = logical(spm_read_vols(spm_vol('rwRight_A1.hdr')));

% List all the realigned images
cd(EPI_Folder)
ImageName = dir('u*.img');
for ImageIndex = 1:length(ImageName)
    % Open the header of a given image
    ImgInfo = spm_vol(ImageName(ImageIndex).name);
    % Read its data
    Volume = spm_read_vols(ImgInfo);
    
    % Get the average signal value in the ROIs
    TimeCourseLeft(ImageIndex) = mean(Volume(Left_A1_Mask)); 
    TimeCourseRight(ImageIndex) = mean(Volume(Right_A1_Mask));
end

figure('Name', 'Signal time in each primary auditory cortices', 'Color', 'w')
hold on
plot(TimeCourseLeft,'b')
plot(TimeCourseRight,'r')

ylabel('Signal Intensity')
xlabel('Scan number')

legend(char({'Left';'Right'}))


cd(StartFolder)



%% Display sections of an image
clear all; clc;

StartFolder = pwd;

StructuralFolder = fullfile(StartFolder, 'BlockDesign', 'Structural');
cd(StructuralFolder)
FilesList = dir('s*.img');
HeaderStructural = spm_vol(FilesList.name);

WorldSpaceCoordinates = [0 0 0];

TransformationMatrix = HeaderStructural.mat;
VoxelIndices = inv(TransformationMatrix)*[WorldSpaceCoordinates' ; 1];
VoxelIndices = round(VoxelIndices);

Volume=spm_read_vols(HeaderStructural);

% Name the figure
figure('Name', sprintf('Voxel coordinate X= %i, Y=%i, Z=%i', ...
       VoxelIndices(1), VoxelIndices(2), VoxelIndices(3)), ...
       'Color', 'k')

% If we want to go for a more sober gray scale and avoid the funky default 
% color map that matlab usually has
colormap(gray)

subplot(2,2,1)
imagesc(squeeze(Volume(VoxelIndices(1),:,:)))
% This following line would plot the image with the right orientation
%imagesc(rot90(squeeze(Volume(Voxel_Coord(1),:,:))',2))

box off
axis 'square'
set(gca,'xtick', [])

subplot(2,2,2)
imagesc(squeeze(Volume(:,VoxelIndices(2),:))')
% This following line would plot the image with the right orientation
%imagesc(flipud(squeeze(Volume(:,Voxel_Coord(2),:))'))

box off
axis 'square'
set(gca,'xtick', [])

subplot(2,2,3)
imagesc(squeeze(Volume(:,:,VoxelIndices(3))))
% This following line would plot the image with the right orientation
%imagesc(fliplr(squeeze(Volume(:,:,Voxel_Coord(3)))))

box off
axis 'square'
set(gca,'xtick', [])


cd(StartFolder)



%% Applying affine transformations to an image
clear all; clc

% Name of the starting folder
StartFolder = pwd;

% Name of the folder containg the structural scan
StructuralFolder = fullfile(StartFolder, 'BlockDesign', 'Structural');

% Finding out the name of the strucural
cd(StructuralFolder)
FilesList = dir('sM00223_002.img');

% Read the content of the header and stores it in a variable
HeaderStructural = spm_vol(FilesList.name);
TransformationMatrix = HeaderStructural.mat;

% Gets the data corresponding to this image
Volume = spm_read_vols(HeaderStructural);

% TRANSLATION
% Creates the vector needed for the spm_matrix function
P_translation = zeros(12,1);
P_translation(1) = 14;
P_translation(2) = -58;
P_translation(3) = 65;
% Creates the translation matrix
Translation = spm_matrix(P_translation,'T');
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
P_rotation = zeros(12,1);
P_rotation(4) = 90*pi/180; 
Rotation = spm_matrix(P_rotation,'R');

TransformationMatrix_Rotation = Rotation * TransformationMatrix;

% getting the header information of the original image
HeaderStructural_Rotated = HeaderStructural;

% and change the name and the transformation matrix in the header
HeaderStructural_Rotated.fname = 'Structural_Rotated.img';
HeaderStructural_Rotated.private.dat.fname = HeaderStructural_Rotated.fname;
HeaderStructural_Rotated.mat = TransformationMatrix_Rotation;

spm_write_vol(HeaderStructural_Rotated, Volume);


cd(StartFolder)