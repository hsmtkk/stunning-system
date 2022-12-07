// Copyright (c) HashiCorp, Inc
// SPDX-License-Identifier: MPL-2.0
import { Construct } from "constructs";
import { App, TerraformStack, CloudBackend, NamedCloudWorkspace } from "cdktf";
import * as google from '@cdktf/provider-google';

const project = 'stunning-system-370901';
const region = 'us-west1';
const repository = 'stunning-system';

class MyStack extends TerraformStack {
  constructor(scope: Construct, id: string) {
    super(scope, id);

    new google.provider.GoogleProvider(this, 'google', {
      project,
      region,
    });

    new google.artifactRegistryRepository.ArtifactRegistryRepository(this, 'my-repository', {
      description: 'docker registry',
      format: 'DOCKER',
      location: region,
      repositoryId: 'my-repository',
    });

    new google.cloudbuildTrigger.CloudbuildTrigger(this, 'build-trigger', {
      filename: 'cloudbuild.yaml',
      github: {
        owner: 'hsmtkk',
        name: repository,
        push: {
          branch: 'main',
        },
      },
    });

    new google.storageBucket.StorageBucket(this, 'my-storage', {
      location: region,
      name: `my-storage-${project}`,
    });

  }
}

const app = new App();
const stack = new MyStack(app, "stunning-system");
new CloudBackend(stack, {
  hostname: "app.terraform.io",
  organization: "hsmtkkdefault",
  workspaces: new NamedCloudWorkspace("stunning-system")
});
app.synth();
