function [ grad_prev, delta_current ] = conv_backprop( del_prev, current, filter )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
s=size(del_prev,2);
grad_prev=zeros(size(filter));
delta_current=zeros(size(current));
current_flip=rot90(current,2);
for i=1:s
    grad_prev(:,:,i)=conv2(current_flip(:,:,i),del_prev(i),'valid');
end
    
filt_flip=rot90(filter,2);
for i=1:s
    delta_current(:,:,i)=conv2(filt_flip(:,:,i),del_prev(i),'valid');
end
end
