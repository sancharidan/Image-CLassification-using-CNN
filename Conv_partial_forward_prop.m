function [feat_maps] = Conv_partial_forward_prop(conv_in, filt)
%this function uses each filter to convolve two feature maps.
[filt_d1, filt_d2, filt_nos]=size(filt);
[inp_d1, inp_d2, inp_nos]=size(conv_in);
feat_maps=zeros(inp_d1-filt_d1+1,inp_d2-filt_d2+1,filt_nos);
for i=1:filt_nos
    feat_maps(:,:,2*i-1)=convn(conv_in(:,:,i), filt(:,:,i), 'valid');
    feat_maps(:,:,2*i)=convn(conv_in(:,:,i+1), filt(:,:,i), 'valid');
end
end
