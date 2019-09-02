[これ](https://qiita.com/arc279/items/b89997bd5c266c6a0248)の動作環境。

## fuzzy ssh connection select for aws ec2 instances

using [fzf](https://github.com/junegunn/fzf).

```
aws ec2 describe-instances \
    --query "Reservations[].Instances[?State.Name=='running' &&  KeyName!=null && PrivateIpAddress!=null][Tags[?Key=='Name'].Value|[0],KeyName,InstanceId,PrivateIpAddress][]" \
  | jq -c 'sort_by(.[0])[]' \
  | fzf -1 \
  | jq -r '"ssh \(.[1])-\(.[2]) -o HostName=\(.[3])"'
```

