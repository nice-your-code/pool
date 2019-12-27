<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;

use App\Exercise;
use App\Handler;

use DateTime;
use DateInterval;

class ExerciseController extends Controller
{
    private $data_from      =  [ 'id'  , 'start_time'                        , 'end_time'          , 'duration'                          , 'max_tempo'                         , 'mean_tempo'                           , 'stroke_count'                               , 'swolf'                              , 'comment'    , 'length_type', 'distance'                            ] ;
    private $data_to        =  [         'start_time'                        , 'total_time'        , 'duration'                          , 'max_tempo'                         , 'mean_tempo'                           , 'stroke_count'                               , 'swolf'                              , 'comment'    , 'length_type', 'distance'                , 'link_id' ] ;
    private $data_to_2      =  [         'start_time'                        , 'total_time'        , 'duration'                          , 'max_tempo'                         , 'mean_tempo'                           , 'stroke_count'                               , 'swolf'                              , 'comment'    , 'length_type', 'distance'                            ] ;
    private $formats        =  [         ['dt','d-m-Y']                      , ['i','%I:%S']       , ['i','%I:%S']                       , ['float',1]                         , ['float',1]                            ,  null                                        , ['float',1]                          ,  null        ,  null        ,  null                     ,  null     ] ;
    private $filters        =  [  null , ['start_time', 'asc_desc', null]    ,  null               , ['duration', 'asc_desc', null]      , ['max_tempo', 'asc_desc', null]     , ['mean_tempo', 'asc_desc', null]       , ['stroke_count', 'asc_desc', null]           , ['swolf', 'asc_desc', null]          , 'custom1'    , 'vals'       , ['distance', 'vals', 100] ,  null     ] ;
    private $names          =  [ '#'   , 'Дата'                              , 'Общая длительность', 'Длительность'                      , 'Максимальный темп'                 , 'Средний темп'                         , 'Количество гребков'                         , 'Swolf'                              , 'Комментарий', 'Тип заплыва', 'Дистанция'               , 'Подробно'] ;
    private $names_2        =  [ '#'   , 'Дата'                              , 'Общая длительность', 'Длительность'                      , 'Максимальный темп'                 , 'Средний темп'                         , 'Количество гребков'                         , 'Swolf'                              , 'Комментарий', 'Тип заплыва', 'Дистанция'                           ] ;

    // ***** Handlers *****
    public function get(Request $request)
    {
        $filt = [];
        $indexes = [];
        $newfilter = null;
        $exercises = Exercise::whereNotNull('id'); // fake call to change type

        if( $request->has('newfilter') )
        {
            $n = $request->input('newfilter');
            $newfilter = $this->filters[$n];
            $newfilter[] = $n;
        }

        if( $request->has('indexes') )
        {
            $indexes = $request->input('indexes');
        }

        if( $request->has('filters') )
        {
            $filt = json_decode($request->input('filters'));
        }

        if($newfilter !== null || count($filt) != 0)
        {
            Log::info('Performing filter: '.json_encode($filt));
            Handler::filter($exercises, $filt, $indexes, $newfilter);
            Log::info(json_encode($indexes));
        }

        $exercises = $exercises->get();
        $exercises = $this->resolveExercise($this->data_from, $this->data_to, $this->formats, $exercises);
        
        $names = $this->names;
        $filters = $this->filters;
        for($i = 0; $i < count($names); $i++)
        {
            if($filters[$i] != null)
            {
                $var = false;
                $name = $names[$i];
                $names[$i] = '';

                if(isset($indexes[$i]) && $indexes[$i] == 'asc')
                {
                    $var = true;
                    $names[$i] = $names[$i].'<span class="dropup">';
                }
                else if(isset($indexes[$i]) && $indexes[$i] == 'desc')
                {
                    $var = true;
                    $names[$i] = $names[$i].'<span class="dropdown">';
                }
                else
                {
                    $names[$i] = $names[$i].'<span>';
                }

                $names[$i] = $names[$i].'<a ';
                
                if($var)
                    $names[$i] = $names[$i].'class="dropdown-toggle" ';

                $names[$i] = $names[$i].'href="'.route('exercises', ['filters' => json_encode($filt), 'indexes' => $indexes, 'newfilter' => $i] ).'">'.$name.'</a>
                </span>';
            }
        }
        $names = json_encode($names);

        return view('exercises', compact('exercises', 'names') );
    }
    
    public function get_by_id(Request $request, $id)
    {
        Log::info("***** Exercise Controller ***** get_by_id start *****");
        $exercise = Exercise::find($id);
        if($exercise == null)
            return abort(404);

        /*/live data blob
        $date = new DateTime();
        $live_data_string = null;
        if($exercise->live_data != null)
        {
            $live_data_string = gzdecode($exercise->live_data);
            Log::info("Live data input (json string):\n".$live_data_string);
            $live_data_names = ["start_time", "heart_rate"];
            $live_data_array =  json_decode($live_data_string, true);
            for($i = 0; $i < count($live_data_array); $i++)
            {
                $live_data_array[$i] = array_intersect_key($live_data_array[$i], array_flip($live_data_names));
                $date->setTimestamp($live_data_array[$i]['start_time'] / 1000);
                $live_data_array[$i]['start_time'] = $date->format('Y-m-d H:i:s');
            }
            $live_data_string = json_encode($live_data_array);
            Log::info("Live data output (json string):\n".$live_data_string);
        }*/

        //addl data blob
        $addl_data_string = null;
        if($exercise->addl_data != null)
        {
            $addl_data_string = gzdecode($exercise->addl_data);
            Log::info("Addl data input (json string):\n".$addl_data_string);
            $addl_data_array  =  json_decode($addl_data_string, true);
            $data             = $addl_data_array['lengths'];
            $pool_length      = $addl_data_array['pool_length'];
            $pool_length_unit = $addl_data_array['pool_length_unit'];
            $total_distance   = $addl_data_array['total_distance'];
            $total_duration   = $addl_data_array['total_duration'] / 1000;
            $addl_data_string = $this->resolveAddl($data);
            Log::info("Addl data output (json string):\n".$addl_data_string);
        }
        
        //exercise
        $exercises   = [];
        $exercises[] = $exercise->toArray();
        $exercise    = $this->resolveExercise($this->data_from, $this->data_to_2, $this->formats, $exercises);
        $names       = json_encode($this->names_2);

        Log::info("***** Exercise Controller ***** get_by_id end *****\n");

        //Do not use live_data_string (by AH)
        $live_data_string = null;

        return view('exercise', compact('id', 'exercise', 'names', 'live_data_string', 'addl_data_string',
                                        'pool_length', 'pool_length_unit', 'total_distance', 'total_duration') );
    }

    // ***** Functions *****
    public function resolveExercise($data_from, $data_to, $formats, $exercises)
    {
        $handlers = [
            'total_time' => function($x, $d)
            {
                $date_end = new DateTime($d['end_time']);
                $date_start = new DateTime($d['start_time']);
                return $date_end->diff($date_start);
            },
            'link_id'    => function($x, $d)
            {
                return '<a href="'.route('get_exercise_by_id', ['id' => $d['id']] ).'">Подробно</a>';
            },
            'duration' => function($x, $d)
            {
                return new DateInterval('PT'.floor(round($x) / 60).'M'.(round($x) % 60).'S');
            }
        ];

        $exercises = Handler::resolveFields($data_from, $data_to, $handlers, $formats, $exercises);
        return json_encode($exercises);
    }

    public function resolveAddl($data)
    {
        $data_from  =  [ 'duration'    , 'interval', 'stroke_count'      , 'stroke_type' ] ;
        $data_to    =  [ 'duration'    , 'interval', 'stroke_count'      , 'stroke_type' ] ;
        $formats    =  [ ["i","%I:%S"] ,  null     ,  null               ,  null         ] ;

        $handlers = [
            'duration' => function($x){
                $x = $x / 1000;
                return new DateInterval('PT'.floor(round($x) / 60).'M'.(round($x) % 60).'S');
            }
        ];

        $data = Handler::resolveFields($data_from, $data_to, $handlers, $formats, $data);

        return json_encode($data);
    }
}
