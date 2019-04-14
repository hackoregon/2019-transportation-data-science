# Generated by Django 2.0.12 on 2019-03-27 07:52

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('civic_sandbox', '0002_disasterneighborhoodview'),
    ]

    operations = [
        migrations.CreateModel(
            name='Foundation',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=80)),
                ('endpoint', models.URLField()),
                ('visualization', models.CharField(choices=[('ChloroplethMap', 'ChloroplethMap'), ('ScatterPlotMap', 'ScatterPlotMap'), ('PathMap', 'PathMap'), ('PolygonPlotMap', 'PolygonPlotMap'), ('IconMap', 'IconMap'), ('ScreenGridMap', 'ScreenGridMap'), ('Text', 'Text')], default='ScatterPlotMap', max_length=30)),
                ('metadata_context', models.URLField()),
            ],
        ),
        migrations.CreateModel(
            name='Packages',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=80)),
                ('description', models.CharField(max_length=200)),
                ('default_foundation', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='default_foundation', to='civic_sandbox.Foundation')),
            ],
        ),
        migrations.CreateModel(
            name='Slide',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=80)),
                ('endpoint', models.URLField()),
                ('visualization', models.CharField(choices=[('ChloroplethMap', 'ChloroplethMap'), ('ScatterPlotMap', 'ScatterPlotMap'), ('PathMap', 'PathMap'), ('PolygonPlotMap', 'PolygonPlotMap'), ('IconMap', 'IconMap'), ('ScreenGridMap', 'ScreenGridMap'), ('Text', 'Text')], default='ChloroplethMap', max_length=30)),
            ],
        ),
        migrations.AddField(
            model_name='packages',
            name='default_slide',
            field=models.ManyToManyField(related_name='default_slides', related_query_name='default_slide', to='civic_sandbox.Slide'),
        ),
        migrations.AddField(
            model_name='packages',
            name='foundations',
            field=models.ManyToManyField(related_name='foundations', related_query_name='foundation', to='civic_sandbox.Foundation'),
        ),
        migrations.AddField(
            model_name='packages',
            name='slides',
            field=models.ManyToManyField(related_name='slides', related_query_name='slide', to='civic_sandbox.Slide'),
        ),
    ]
