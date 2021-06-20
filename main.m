clear all
clc

datanames = {'BZR', 'COX2', 'DHFR', 'PROTEINS_full', 'AIDS'};

iterations = 5;
hashDims = 50:50:300;
turns = 10;
cs = 
method = 'hashwls';

accs = zeros(iterations, length(hashDims), turns);
cpus = zeros(iterations, length(hashDims), turns);

for idataname = 1:length(datanames)
    
   dataname =  datanames{idataname};
   load(['data/', dataname, '/',dataname, '.mat']);
   
   for r = 1:iterations
       for iHash = 1:length(hashDims)
           for iturn = 1:turns
                if strcmp(dataname, 'COX2')
                    c = 0.7;
                else
                    c = 1;
                end
               [accs(r, iHash, iturn), cpus(r, iHash, iturn)] = hashwls(graphs, labels, r, hashDims(iHash),c);

           end
       end
   end
   
   if ~exist(['results/', dataname, '/'], 'dir')
        mkdir(['results/', dataname, '/']);
   end
   accs_mean = mean(accs, 3);
   cpus_mean = mean(cpus, 3);
   save(['results/', dataname, '/', dataname, '_', method, '_sum_results.mat'], 'accs', 'cpus', 'accs_mean', 'cpus_mean')
end