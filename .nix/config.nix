{
  ## DO NOT CHANGE THIS
  format = "1.0.0";
  ## unless you made an automated or manual update
  ## to another supported format.

  ## The attribute to build from the local sources,
  ## either using nixpkgs data or the overlays located in `.nix/coq-overlays`
  ## Will determine the default main-job of the bundles defined below
  attribute = "mathcomp-real-closed";

  ## If you want to select a different attribute (to build from the local sources as well)
  ## when calling `nix-shell` and `nix-build` without the `--argstr job` argument
  # shell-attribute = "{{nix_name}}";

  ## Maybe the shortname of the library is different from
  ## the name of the nixpkgs attribute, if so, set it here:
  # pname = "{{shortname}}";

  ## Lists the dependencies, phrased in terms of nix attributes.
  ## No need to list Coq, it is already included.
  ## These dependencies will systematically be added to the currently
  ## known dependencies, if any more than Coq.
  ## /!\ Remove this field as soon as the package is available on nixpkgs.
  ## /!\ Manual overlays in `.nix/coq-overlays` should be preferred then.
  # buildInputs = [ ];

  ## Indicate the relative location of your _CoqProject
  ## If not specified, it defaults to "_CoqProject"
  # coqproject = "_CoqProject";

  ## select an entry to build in the following `bundles` set
  ## defaults to "default"
  default-bundle = "8.19";

  ## write one `bundles.name` attribute set per
  ## alternative configuration
  ## When generating GitHub Action CI, one workflow file
  ## will be created per bundle
  bundles = let
    common-bundles = {
      coqeal.override.version = "master";
      mathcomp-apery.override.version = "master";
      mathcomp-algebra-tactics.override.version = "master";
      mathcomp-bigenough.override.version = "master";
      mathcomp-finmap.override.version = "master";
      mathcomp-zify.override.version = "master";
      multinomials.override.version = "master";
      mathcomp-abel.override.version = "master";
    }; in {
  "8.17".coqPackages = common-bundles // {
    coq.override.version = "8.17";
    mathcomp.override.version = "2.1.0";
  };
  "8.18".coqPackages = common-bundles // {
    coq.override.version = "8.18";
    mathcomp.override.version = "2.2.0";
  };
  "8.19".coqPackages = common-bundles // {
    coq.override.version = "8.19";
    mathcomp.override.version = "2.2.0";
  };
  "master".coqPackages = common-bundles // {
    coq.override.version = "master";
    bignums.override.version = "master";
    paramcoq.override.version = "master";
    coq-elpi.override.version = "master";
    hierarchy-builder.override.version = "master";
    mathcomp.override.version = "master";
  };
  "master".ocamlPackages = {
    elpi.override.version = "1.19.2";
  };
  };

  ## Cachix caches to use in CI
  ## Below we list some standard ones
  cachix.coq = {};
  cachix.math-comp.authToken = "CACHIX_AUTH_TOKEN";
  cachix.coq-community = {};
  
  ## If you have write access to one of these caches you can
  ## provide the auth token or signing key through a secret
  ## variable on GitHub. Then, you should give the variable
  ## name here. For instance, coq-community projects can use
  ## the following line instead of the one above:
  # cachix.coq-community.authToken = "CACHIX_AUTH_TOKEN";
  
  ## Or if you have a signing key for a given Cachix cache:
  # cachix.my-cache.signingKey = "CACHIX_SIGNING_KEY"
  
  ## Note that here, CACHIX_AUTH_TOKEN and CACHIX_SIGNING_KEY
  ## are the names of secret variables. They are set in
  ## GitHub's web interface.
}
