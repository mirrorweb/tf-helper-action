# tf-helper-action

This action is a very basic wrapper for the terraform api shell program [tf-helper](https://github.com/hashicorp-community/tf-helper).

In it's current state all it provides is a docker container providing access to the program to run in Github Actions.

## Disclaimer

Due to the nature of it's interaction with Terraform this action is potentially destructive, although your Terraform Cloud configuration
should prevent this.

## Usage

Place in a `.yml` file such as this one in your `.github/workflows` folder. [Refer to the documentation on workflow YAML syntax here.](https://help.github.com/en/articles/workflow-syntax-for-github-actions)

The example below will trigger a queue action on the workspace specified in TFH_NAME for the organization in Terraform Cloud specified in TFH_ORG.

The message field for `pushconfig` commands must not have spaces in it for the time being due to some issues with how Github Actions formats INPUT vars.

```yaml
name: TF Helper Action
on: push

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: ./
      with:
        1: "\"pullvars:::-var cf_default_root_object\""
        2: "\"pushconfig:::-message GithubActionTesting -vcs 0 -current-config false\""
      env:
        TFH_token: ${{ secrets.TFH_TOKEN }}
        TFH_org: mirrorweb
        TFH_name: mw-tna-dmz-staging
```

Only `pullvars`, `pushvars` and `pushconfig` are currently supported.

A full information on the available commands can be found in the [tf-helper](https://github.com/hashicorp-community/tf-helper) repo.

## Configuration

The following settings must be passed as environment variables as shown in the example. Sensitive information should be [set as encrypted secrets](https://help.github.com/en/articles/virtual-environments-for-github-actions#creating-and-using-secrets-encrypted-variables) — otherwise, they'll be public to anyone browsing your repository.

| Key | Value | Suggested Type | Required |
| ------------- | ------------- | ------------- | ------------- |
| `THF_TOKEN` | You org or workspace token for terraform cloud | `secret` | **Yes** |
| `TFH_ORG` | The name of the organization in Terraform Cloud. | `env` | **Yes** |
| `TFH_NAME` | The name of the workspace in Terraform Cloud. | `env` | **Yes** |

## Licence

This project is distributed under the [MIT license](LICENSE.md).

