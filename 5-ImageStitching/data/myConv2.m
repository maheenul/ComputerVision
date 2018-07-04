function [resultConv] = myConv2(img,mat)
%
% Convulution function (2 X for loops)
% Can take in double or uint8 for img or mat
% Does not include the blacked out edges
%
sizemat = size(mat);
sizeimg = size(img);

ResultConvRow = (sizeimg(1)-sizemat(1)+1);
ResultConvColumn = (sizeimg(2)-sizemat(2)+1);
img=double(img);
resultConv = zeros(ResultConvRow,ResultConvColumn);

for iterx = 1:1:(ResultConvColumn)
    for itery = 1:1:(ResultConvRow)
        resultConv(itery,iterx) = sum(sum(img(itery:(itery+sizemat(1)-1),iterx:(iterx+sizemat(1)-1)).*mat));
        
    end
end