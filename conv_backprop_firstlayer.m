function [ grad ] = conv_backprop_firstlayer( inp, filter, conv_res_del )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
flip_inp=rot90(inp,2);
grad=zeros(size(filter));
%[grad_w,grad_h,grad_ch,grad_nos]=size(filter);
for i=1:3%runs over 3 channels
    for j=1:10%runs over 10 feature maps
        filt1(:,:,i,j)=conv2(flip_inp(:,:,i),conv_res_del(:,:,j),'valid');
    end
end
end