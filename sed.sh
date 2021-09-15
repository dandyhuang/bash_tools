
for j in `ls |grep DataProxy_824`; 
do
        echo $j;
        array=(${j//_/ }) 
        for var in ${array[@]}
        do
           echo $var
        done
        count=0
        if [ ${array[2]} -le 4 ]
        then
           echo "le:$j"
           continue
        fi

        cd $j/conf;
        for i in `find . -type f`;
        do
                echo "count======"$count
                if [ "$i" == "./server.conf.xml" ]
                then 
                        port=9600
                        let port=port+${array[2]} 
                        http_port=19600
                        let http_port=http_port+${array[2]} 
                        echo "$i,$port";
                       sed -i "s/Port=\"9601\"/Port=\"$port\"/g"        "$i";
                       sed -i "s/http_port Value=\"19601\"/http_port Value=\"$http_port\"/g"    "$i";

                        let count++
                fi
                if [ "$i" == "./bin.conf" ]
                then
                        # 使用""号
                        echo "binconf:"$i
                        sed -i  "s/DataProxy1_824/DataProxy_824_${array[2]}/g" "$i";
                fi
        done
        cd -
done
