# Visual Studio Code for the Web
Visual Studio Code for the Web provides a free, zero-install Microsoft Visual Studio Code experience running entirely in your browser.

- https://github.com/linuxserver/docker-code-server
- https://github.com/coder/code-server


## Parameters
https://github.com/linuxserver/docker-code-server?tab=readme-ov-file#parameters

- `TZ`: Specify a timezone
- `PASSWORD`: (Optional) Password for the web gui, if `PASSWORD` or `HASHED_PASSWORD` is not provided, there will be no auth.
- `SUDO_PASSWORD`: (Optional) If this is set, user will have sudo access in the code-server web gui with the specified password.
  - Without this setting you can still become root with `docker exec -it code-server bash`
- `HASHED_PASSWORD`: (Optional) Overrides `PASSWORD`.
- `SUDO_PASSWORD_HASH`: (Optional) Overrides `SUDO_PASSWORD`.
- `DEFAULT_WORKSPACE`: (Optional) Specify a default directory.


### Generate hashed Password
```shell
echo -n "thisismypassword" | npx argon2-cli -e
$argon2i$v=19$m=4096,t=3,p=1$wst5qhbgk2lu1ih4dmuxvg$ls1alrvdiwtvzhwnzcm1dugg+5dto3dt1d5v9xtlws4
```

If you're using Docker Compose file, in order to make this work, you need to change all the single `$` to `$$`:
```
$$argon2i$$v=19$$m=4096,t=3,p=1$$wST5QhBgk2lu1ih4DMuxvg$$LS1alrVdIWtvZHwnzCM1DUGg+5DTO3Dt1d5v9XtLws4
```
