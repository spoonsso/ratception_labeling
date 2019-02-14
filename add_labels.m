% Read in files from an imDir, add in labels one marker at a time,
% and manually screen for quality and occlusions. Save output into
% dedicated folders to be used for sagemaker examples.

imdir = './results/calibrd4_50frames_cams356/';

load([imdir 'imDir/allcoords.mat']);

%#ims = dir('./results/calibrd4_50frames_cams356/imDir/*.png');

figure;
for j = 1:2
    exdir = [imdir 'ex' num2str(j)]
    if ~isdir(exdir)
        mkdir(exdir)
    end
    
for i = 1:30%size(filenames,1)
    fn = strtrim(filenames(i,:));
    fn_ = [imdir fn(4:end)];
    im = imread(fn_);
    hold off;
    imagesc(im);
    hold on;
    plot(allcoords(i,j,2),allcoords(i,j,3),'or','markersize',10);
    kk = waitforbuttonpress;

    if kk == 1 %pressed key on keyboard, accept this as a good example
        %save this image + marker overlay to its own folder
        imname = fn_(strfind(fn_,'sample'):end);
        %print();
        f = getframe(gca);
        imwrite(f.cdata,[exdir '/example_' imname]);
    end

end

end

