Setup a pipeline with a GitHub action in your account from AWS console, then save a copy from the CLI:

aws codepipeline get-pipeline --name MyPipeline > pipeline.json

1) edit pipeline.json to change require fields:
2) remove the metadata section from the pipeline structure in the JSON file (the "metadata": { } lines and the "created," "pipelineARN," and "updated" fields within)

Then updated the pipeline:
aws codepipeline update-pipeline --cli-input-json file://pipeline.json

NOTE: The pipeline name cannot be changed.