# `erber`
Here in devops-land, I find myself needing to do template substitutions on the regular--enough that it'd be a pain to do it with `sed` but not enough that I want to build a dedicated tool for that one project. (I had enough of that with [`terraframe`](https://github.com/eropple/terraframe), I don't need more.)

So today I whipped out `erber`, a simple 

All you need to do to use `erber` is:
```bash
gem install erber

erber -p props1.json -p props2.yaml template.txt.erb > your_output.txt
```

One note: `erber` uses `Hashie::Mash` internally, so you can use either method names or hash chain syntax, as you prefer. I don't judge.

## Contributing

1. Fork it ( https://github.com/eropple/erber/fork )
2. Create your feature branch (`git checkout -b develop/my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin develop/my-new-feature`)
5. Create a new Pull Request!
