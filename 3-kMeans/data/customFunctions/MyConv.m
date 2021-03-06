function [ResultConv] = MyConv(img,mat)
%
% Convulution function (2 X for loops)
% Can take in double or uint8 for img or mat
% Includes the blacked out edges

img=double(img);
ResultConv = zeros(size(img));

for ix = 1:1:(size(img,2)-size(mat,2)+1)
    for iy = 1:1:(size(img,1)-size(mat,1)+1)
        ResultConv(iy+(size(mat,1)-1)*0.5,ix+(size(mat,2)-1)*0.5) =...
           sum(sum(img(iy:(iy+size(mat,1)-1),ix:(ix+size(mat,1)-1)).*mat));
    end
end