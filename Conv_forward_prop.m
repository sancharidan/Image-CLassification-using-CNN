function [feat_maps] = Conv_forward_prop(conv_in, filt, layer_ind)


if layer_ind==1 %applies only to first conv layer
    [filt_d1, filt_d2, filt_ch, filt_nos]=size(filt);
    [inp_d1, inp_d2, inp_ch]=size(conv_in);
    feat_maps=zeros(inp_d1-filt_d1+1,inp_d2-filt_d2+1,filt_nos);
    for i=1:filt_nos
        feat_maps(:,:,i)=convn(conv_in, filt(:,:,:,i), 'valid');
    end
else
    [filt_d1, filt_d2, filt_nos]=size(filt);
    [inp_d1, inp_d2, inp_nos]=size(conv_in);
    feat_maps=zeros(inp_d1-filt_d1+1,inp_d2-filt_d2+1,filt_nos);
    for i=1:filt_nos
        feat_maps(:,:,i)=conv2(conv_in(:,:,i), filt(:,:,i),'valid');
    end
end 
end
