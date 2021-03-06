{ lib
, buildPythonPackage
, fetchPypi
, pytest
, pytestcov
, pytest-doctestplus
, pytestCheckHook
, setuptools_scm
}:

buildPythonPackage rec {
  pname = "pytest-filter-subpackage";
  version = "0.1.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1s4s2kd31yc65rfvl4xhy8xx806xhy59kc7668h6b6wq88xgrn5p";
  };

  nativeBuildInputs = [
    setuptools_scm
  ];

  propagatedBuildInputs = [
    pytest
    pytest-doctestplus
    pytestcov
    pytestCheckHook
  ];

  # missing some files
  disabledTests = [ "with_rst" ];

  meta = with lib; {
    description = "Meta-package containing dependencies for testing";
    homepage = "https://astropy.org";
    license = licenses.bsd3;
  };
}
