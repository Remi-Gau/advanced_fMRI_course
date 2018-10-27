function DisplayJointHistogram(Image1,Image2)
% USAGE DisplayJointHistogram(Image1,Image2)
% Display joint histogram of 2 images.
% Image1 : name of first image. Must be in Nifti format
% Image2 : name of first image. Must be in Nifti format


VG = spm_vol(Image1); % Opens volumes
VF = spm_vol(Image2);

VG.uint8 = loaduint8(spm_vol(Image1)); % Converts them, see below
VF.uint8 = loaduint8(spm_vol(Image2));

% Display joint histograms
%--------------------------------------------------------------------------
H   = spm_hist2(VG.uint8,VF.uint8,VF.mat\VG.mat,[1 1 1]); % A spm mex file that compute the values of the histogram
tmp = log(H+1);

fig = figure(3);
ax  = axes('Visible','off','Parent',fig);
image(tmp*(64/max(tmp(:))),'Parent',ax');

set(ax,'DataAspectRatio',[1 1 1], 'PlotBoxAspectRatioMode','auto','XDir','normal','YDir','normal', 'XTick',[],'YTick',[]);

title('Original Joint Histogram','Parent',ax);

xlabel(VG.fname,'Parent',ax);
ylabel(VF.fname,'Parent',ax);



%==========================================================================
% function udat = loaduint8(V)
%==========================================================================
function udat = loaduint8(V)
% Load data from file indicated by V into an array of unsigned bytes.
if size(V.pinfo,2)==1 && V.pinfo(1) == 2
    mx = 255*V.pinfo(1) + V.pinfo(2);
    mn = V.pinfo(2);
else
    mx = -Inf; mn =  Inf;
    for p=1:V.dim(3)
        img = spm_slice_vol(V,spm_matrix([0 0 p]),V.dim(1:2),1);
        mx  = max([max(img(:))+paccuracy(V,p) mx]);
        mn  = min([min(img(:)) mn]);
    end
end

% Another pass to find a maximum that allows a few hot-spots in the data.
nh = 2048;
h  = zeros(nh,1);
for p=1:V.dim(3)
    img = spm_slice_vol(V,spm_matrix([0 0 p]),V.dim(1:2),1);
    img = img(isfinite(img));
    img = round((img+((mx-mn)/(nh-1)-mn))*((nh-1)/(mx-mn)));
    h   = h + accumarray(img,1,[nh 1]);
end
tmp = [find(cumsum(h)/sum(h)>0.9999); nh];
mx  = (mn*nh-mx+tmp(1)*(mx-mn))/(nh-1);


udat = zeros(V.dim,'uint8');
st = rand('state'); % st = rng;
rand('state',100); % rng(100,'v5uniform'); % rng('defaults');
for p=1:V.dim(3)
    img = spm_slice_vol(V,spm_matrix([0 0 p]),V.dim(1:2),1);
    acc = paccuracy(V,p);
    if acc==0
        udat(:,:,p) = uint8(max(min(round((img-mn)*(255/(mx-mn))),255),0));
    else
        % Add random numbers before rounding to reduce aliasing artifact
        r = rand(size(img))*acc;
        udat(:,:,p) = uint8(max(min(round((img+r-mn)*(255/(mx-mn))),255),0));
    end

end

rand('state',st); % rng(st);


%==========================================================================
% function acc = paccuracy(V,p)
%==========================================================================
function acc = paccuracy(V,p)
if ~spm_type(V.dt(1),'intt')
    acc = 0;
else
    if size(V.pinfo,2)==1
        acc = abs(V.pinfo(1,1));
    else
        acc = abs(V.pinfo(1,p));
    end
end