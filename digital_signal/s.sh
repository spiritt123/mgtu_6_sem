for id in $(seq 3 8);
do
    ( cd "lab$id" && make_lab )
done
