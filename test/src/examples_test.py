import tftest
import pytest


@pytest.fixture()
def plan(request, directory="../../examples/complete"):
    tf = tftest.TerraformTest('plan', directory, module_name="my_tf_module")
    tf.setup()
    plan = tf.plan(
        output=True, use_cache=True
    )
    return plan
