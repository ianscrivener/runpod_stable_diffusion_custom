#!/bin/bash
echo "Container Started"
export PYTHONUNBUFFERED=1
source /workspace/stable-diffusion-webui/venv/bin/activate

cd /workspace/

# on first boot
if [[ -f "is_first_boot" ]] 
then
    rm is_first_boot


    if [[ $s3_access_key ]] && [[ $s3_secret_key ]]
    then
        rm is_first_boot

        #1 get custom post_install_script & run it  
        if [[ $post_install_script ]]
        then
            s3cmd get $post_install_script \
                post_install.sh \    
                --access_key=$s3_access_key \
                --secret_key=$s3_secret_key
            source post_install. sh
        fi

        #2 get custom Stable Diffusion config
        if [[ $sd_config ]]
        then
            s3cmd get $sd_config \
                /workspace/stable-diffusion/config.json \
                --access_key=$s3_access_key \
                --secret_key=$s3_secret_key
        fi

        #3 get custom post_reboot script  
        if [[ $post_reboot_script ]]
        then
            s3cmd get $post_reboot_script \
                post_reboot.sh \    
                --access_key=$s3_access_key \
                --secret_key=$s3_secret_key
        fi
    fi

# on re boot
else    

    # run bash script after reboot
    if [[ -f post_reboot.sh ]]
    then
        source post_reboot. sh
    fi

fi




cd /workspace/stable-diffusion-webui

python relauncher.py &

if [[ $PUBLIC_KEY ]]
then
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    cd ~/.ssh
    echo $PUBLIC_KEY >> authorized_keys
    chmod 700 -R ~/.ssh
    cd /
    service ssh start
    echo "SSH Service Started"
fi

if [[ $JUPYTER_PASSWORD ]]
then
    ln -sf /examples /workspace
    ln -sf /root/welcome.ipynb /workspace

    cd /
    jupyter lab --allow-root --no-browser --port=8888 --ip=* \
        --ServerApp.terminado_settings='{"shell_command":["/bin/bash"]}' \
        --ServerApp.token=$JUPYTER_PASSWORD --ServerApp.allow_origin=* --ServerApp.preferred_dir=/workspace
    echo "Jupyter Lab Started"
fi

sleep infinity
