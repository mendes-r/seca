# Web Application Security


---

## Exploitation

### > Recon

#### >> Network Analysis Tools

- Browser's tools
- Burp
- ZAP

#### >> Search Engine Caches

[Google](https://google.com):

By using `inurl<pattern>` to reject any url that match that pattern.

```
site:example.com login -inurl:logout
```

> _Relevant information:_
>
> - explore _Google Dorks_
> - try other search engines like [Bing](https://bing.com) or [Yandex](https://yandex.com)


#### >> Accidental Archives

Search for previous public information that can point to now privite subdomains. Usually found in hyperlinks.

[Archive.org](https://web.archive.org/)

Get a copy of the old HTML and performa a search for the most [common URL schemes](https://www.iana.org/assignments/uri-schemes/uri-schemes.xhtml).

- _http://_
- _https://_
- _file://_
- _ftp://_
- _ftps://_

#### >> Social Media Snapshots 

Using paid APIs, e.g. [_Twitter API_](https://developer.x.com/en/docs/x-api).

#### >> Zone Transfer Attacks [not really an attack]

```sh
# request the nameservers that are responsible for resolving url
host -t example.com 

# request a zone transfer file for example.com in order to update our record
host -l example.com ns1.example.com 
```

> _Relevant information:_
>
> - works only with improperly configured Domain Name Systems (DNS) servers

#### >> Brute Forcing

```sh
<subdomain-guess>.example.com # and wait for a response
```

> _Relevant information:_
>
> - time-consuming, rate-limits, regex ...
> - easily logged.

---

## Countermeasures

---

## Bug Bounties

[HackerOne](https://hackerone.com/opportunities/all/search?ordering=Highest+bounties) Number 1 platform.

[Bug-Bounties](https://bug-bounties.as93.net/) A compiled list of companies which accept responsible disclosure.

[Immunefy](https://immunefi.com/) Specifically for Web3.

[BugCrowd](https://www.bugcrowd.com/bug-bounty-list/)

[Intigriti](https://www.intigriti.com/)

[IssueHunt](https://issuehunt.io/)