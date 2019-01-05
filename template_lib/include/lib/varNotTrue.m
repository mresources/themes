With[{
  tempArgs=
    (Join@@
      Flatten@{
        #,
        Replace[Templating`$TemplateArgumentStack,{
            {___,a_}:>a,
            _-><||>
          }]
        })
  },
  Replace[
    tempArgs@
      Replace[tempArgs["var"],
        t_TemplateObject:>
          TemplateApply[t,tempArgs]
        ],
    TemplateObject[{
      Templating`Evaluator`PackagePrivate`apply[_,
        a_
        ]
      }]:>
        Block[
          {
            Templating`PackageScope`$TemplateEvaluate=True
            },
          a
          ]
    ]=!=True
  ]&
