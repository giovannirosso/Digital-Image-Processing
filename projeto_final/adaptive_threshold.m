% ## Authors: Mateus Mello de Oliveira
% ##          Giovanni de Rosso Unruh
% ## Created: 2020-10-20

function img_thresh = adaptive_threshold (img, windowSize, step)

  [sizex sizey] = size(img);
  img_thresh = uint8(zeros(sizex, sizey));
   
  for i = 1:step:sizex-windowSize
    for j = 1:step:sizey-windowSize
      window = img(i:i+windowSize-1, j:j+windowSize-1);
      th = graythresh(window);
      img_window = im2bw(window, th);
      img_thresh(i:windowSize + i-1, j:windowSize + j-1) = img_window;
    end
  end
  
  img_thresh = logical(img_thresh);
  
end
