[< back](../../TABLE_OF_CONTENT.md)

# Zone Transfer Attacks [not really an attack]

```sh
# request the nameservers that are responsible for resolving url
host -t example.com 

# request a zone transfer file for example.com in order to update our record
host -l example.com ns1.example.com 
```

> _Relevant information:_
>
> - works only with improperly configured Domain Name Systems (DNS) servers
