%% Example: 

% %                 load('data.mat')
% %                 im_raw = data{1};
% %                 im_gt = logical(data{2});
% %                 [im_bin,RI_wa]= f_i2mtc2020(im_raw,im_gt);
% %                 figure; imshow(im_bin); colormap bone; 
%%

function [im_bin,RI_wa]= f_i2mtc2020(im_raw,im_gt)
type_window = 7;
type_wavelet = 'sym5';
type_level = 5;

im_contrast = f_skavg(im_raw,type_window);
im_synth = f_denoising(im_contrast,type_wavelet,type_level);
im_bin = f_clustering(im_synth,im_contrast);
RI_wa = f_randindex(im_gt, im_bin); 

end

 

function im_contrast = f_skavg(im_raw,type_window)
type_numberslides = 30;

for type_slide = 1:1:type_numberslides
    
    im_input = im_raw(:,:,type_slide);
    d = (type_window-1)/2;
    
    mat_header = im_input(1:d,:);
    mat_footer = im_input(end+1-d:end,:);
    mat_inside = [mat_header;im_input;mat_footer];
    mat_left = mat_inside(:,1:d);
    mat_right = mat_inside(:,end-d+1:end);
    im_aux = [mat_left, mat_inside, mat_right];
    
    [rows,cols]=size(im_aux);
    im_contrast_aux = zeros(rows,cols);
    
    for i=1+d:1:rows-d
        for j=1+d:1:cols-d
            val_window = im_aux(i-d:i+d,j-d:j+d);
            val_mean = mean2(val_window);
            val_std = std2(val_window);
            val_contrast = val_std/val_mean;
            im_contrast_aux(i,j) = val_contrast;
        end
    end
    im_contrast_slides(:,:,type_slide) = im_contrast_aux(d+1:end-d,d+1:end-d);
end

im_contrast = mean(im_contrast_slides,3);
im_contrast = mat2gray(im_contrast);

end

function im_synth = f_denoising(im_contrast,type_wavelet,type_level)
[C,S] = wavedec2(im_contrast,type_level,type_wavelet);
A = appcoef2(C,S,type_wavelet);

switch type_level
    case 1
        R = idwt2(A,[],[],[],type_wavelet);
        
    case 2
        R1 = idwt2(A,[],[],[],type_wavelet);
        R = idwt2(R1,[],[],[],type_wavelet);
        
    case 3
        R1 = idwt2(A,[],[],[],type_wavelet);
        R2 = idwt2(R1,[],[],[],type_wavelet);
        R = idwt2(R2,[],[],[],type_wavelet);
        
    case 4
        R1 = idwt2(A,[],[],[],type_wavelet);
        R2 = idwt2(R1,[],[],[],type_wavelet);
        R3 = idwt2(R2,[],[],[],type_wavelet);
        R = idwt2(R3,[],[],[],type_wavelet);
        
    case 5
        R1 = idwt2(A,[],[],[],type_wavelet);
        R2 = idwt2(R1,[],[],[],type_wavelet);
        R3 = idwt2(R2,[],[],[],type_wavelet);
        R4 = idwt2(R3,[],[],[],type_wavelet);
        R = idwt2(R4,[],[],[],type_wavelet);
        
    otherwise
        disp('Error in level of decomposition')
end

im_synth = R;

end

function im_bin = f_clustering(im_synth,im_contrast)

im_synth = uint8(250 * mat2gray(im_synth));
l = imsegkmeans(im_synth,2);

[m,n] = size(l);
for x = 1:1:m
    for y = 1:1:n
        if l(x,y) == 2
            l2(x,y) =  true;
        else
            l2(x,y) = false;
        end
    end
end

im_region = l2;
elements = regionprops('table',im_region,'Area');
im_bwarea = bwareaopen(im_region,max(elements.Area));
[a, b] = size(im_contrast);
aux_marker = zeros(a,b);

for i = 1:1:a
    for j = 1:1:b        
        if im_bwarea(i,j) == 1
            aux_marker(i,j) = im_synth(i,j);
        end       
    end
end

im_bin = logical(aux_marker);

end

function RI = f_randindex(im_gt, im_bin)

adder = im_gt + im_bin;
TP = length(find(adder == 2));
TN = length(find(adder == 0));
subtr = im_gt - im_bin;
FP = length(find(subtr == -1));
FN = length(find(subtr == 1));
RI = (TP+TN)/(TP+TN+FP+FN);

end