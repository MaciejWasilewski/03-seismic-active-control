dt=0.01;
            toClear_a1=5.813*10^9;
            toClear_a2=5.464*10^7;
            toClear_a3=1.621*10^3;
            toClear_delta1=[...
                1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1];
            toClear_delta2=[...
                1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];
            matMass=[...
                336417.751823794 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 339878.441884166 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 338937.585051223 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 340340.409554015 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 230498.591296110 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 230354.067126922 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 318517.572906172 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 231814.996834797 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 228232.918819199 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 227670.007651472 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 228932.185286095 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 333788.421452572 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 338444.171566820 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 336702.133561221 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 275437.710062381 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 228987.222295201 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 227620.215720082 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 232878.061055921 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 340714.109580025 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 340950.573136700];
            matStiffn=[...
                166865291.975192 -108652912.391809 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                -108652912.391809 199251802.493919 -90598890.1021096 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 -90598890.1021096 175868995.243429 -85270105.1413196 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 -85270105.1413196 167213095.549100 -81942990.4077801 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 -81942990.4077801 186639324.762481 -104696334.354701 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 -104696334.354701 182059820.585433 -77363486.2307325 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 -77363486.2307325 151301578.600539 -73938092.3698061 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 -73938092.3698061 173738870.023909 -99800777.6541032 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 -99800777.6541032 164503205.559644 -64702427.9055411 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 -64702427.9055411 144597896.121699 -79895468.2161579 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 -79895468.2161579 142451566.603062 -62556098.3869044 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 -62556098.3869044 134913996.566360 -72357898.1794553 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 -72357898.1794553 137696178.847393 -65338280.6679378 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 -65338280.6679378 120426929.169257 -55088648.5013190 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 -55088648.5013190 115313072.086107 -60224423.5847885 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 -60224423.5847885 129082837.669094 -68858414.0843053 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -68858414.0843053 119409245.540662 -50550831.4563571 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -50550831.4563571 96214242.4421694 -45663410.9858123 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -45663410.9858123 79653148.3382235 -33989737.3524112;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -33989737.3524112 33989737.3524112];
            matDamps=[...
                9411784.18255396 -290.989155426071 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                -290.989155426071 8525216.88115899 -8524925.89200356 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 -8524925.89200356 18035708.5280207 -9510782.63601714 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 -9510782.63601714 21510036.8853744 -11999254.2493573 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 -11999254.2493573 26526865.6827985 -14527611.4334412 0 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 -14527611.4334412 24417299.2170685 -9889687.78362727 0 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 -9889687.78362727 22534873.6083108 -12645185.8246835 0 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 -12645185.8246835 33284789.9154454 -20639604.0907619 0 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 -20639604.0907619 25593141.9420105 -4953537.85124867 0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 -4953537.85124867 4953820.71550668 -282.864258002772 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 -282.864258002772 14224667.6682051 -14224384.8039471 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 -14224384.8039471 24525484.2838207 -10301099.4798735 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 -10301099.4798735 22045146.0950819 -11744046.6152084 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 -11744046.6152084 22822248.3978571 -11078201.7826487 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 -11078201.7826487 20692993.1691170 -9614791.38646827 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 -9614791.38646827 16465335.3941262 -6850544.00765798 0 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -6850544.00765798 6850718.93039405 -174.922736070051 0 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -174.922736070051 7309893.66489496 -7309718.74215889 0;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -7309718.74215889 17389579.6951735 -10079860.9530146;...
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -10079860.9530146 10079860.9530146];
            matACont=[...
                zeros(20,20),eye(20,20),zeros(20,20);...
                -inv(matMass)*matStiffn,-inv(matMass)*matDamps,6*inv(matMass)*toClear_delta2;...
                -toClear_a1*toClear_delta1,-toClear_a2*toClear_delta1,-toClear_a3*eye(20)];
            matBCont=[zeros(20,21);zeros(20,20),ones(20,1);toClear_a1*eye(20),zeros(20,1)];
            matC=[-inv(matMass)*matStiffn,-inv(matMass)*matDamps,6*inv(matMass)*toClear_delta2];
            Q=[1/2*matStiffn,zeros(20,40);zeros(20,20),1/2*matMass,zeros(20,20);zeros(20,60)];
            R=5000000*eye(20);
            n=9;
            N=750;
            min_N=35;
            
            clear -regexp ^toClear_;
            