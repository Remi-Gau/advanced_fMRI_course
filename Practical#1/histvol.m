function [n, x]=histvol(V, nbins)
% Create Histogram of an image volume
% FORMAT [n, x]=histvol(V, nbins)
% V     - mapped image volume (see spm_vol)
% nbins - number of bins to use.
% n     - number of counts in each bin
% x     - position of bin centres
%_______________________________________________________________________
% @(#)JohnsGems.html	1.42 05/02/02

if nargin==1, nbins = 256; end;

% determine range...
mx = -Inf;
mn =  Inf;
for p=1:V.dim(3),
	img = spm_slice_vol(V,spm_matrix([0 0 p]),V.dim(1:2),1);
	msk = find(isfinite(img));
	mx  = max([max(img(msk)) mx]);
	mn  = min([min(img(msk)) mn]);
end;

% compute histograms...
x = [mn:(mx-mn+1)/nbins:mx];
n = zeros(size(x));
for p=1:V.dim(3),
	img = spm_slice_vol(V,spm_matrix([0 0 p]),V.dim(1:2),1);
	msk = find(isfinite(img));
	n   = n+hist(img(msk),x);
end;
return;