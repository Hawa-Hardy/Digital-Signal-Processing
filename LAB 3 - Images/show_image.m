function [ph] = show_image(imc, figno, scaled, map)
%SHOW_IMG    display an image with possible scaling
% usage...   ph = show_img(imc, figno, scaled, map)
% imc = input image
% figno = figure number to use for the plot
%           if 0, re-use the same figure
%           if omitted a new figure will be opened
% optional args:
% scaled = 1 (TRUE) to do auto-scale (DEFAULT)
%           not equal to 1 (FALSE) to inhibit scaling
% map = user-specified color map
% ph = figure handle
%---

if nargin > 1
    if (figno > 0)
        figure(figno);
    end
else
    figure;
end
if nargin < 3
    scaled = 1;           %--- TRUE
end;
if (scaled)
    mx = max(max(imc));
    mn = min(min(imc));
    omc = round(255*(imc-mn)/(mx-mn));
elseif (~scaled)
    omc = round(imc);
    I = find(omc < 0);
    omc(I) = zeros(size(I));
    I = find(omc > 255);
    omc(I) = 255 * ones(size(I));
end;
if nargin < 4
    colormap(gray(256));  %--- linear color map
else
    omc = imc;
    colormap(map);
end;
ph = image(omc);
axis('image')
end